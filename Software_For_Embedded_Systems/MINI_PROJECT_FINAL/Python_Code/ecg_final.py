# This Project is Created by ASHUTOSH RAJENDRA KARVE
# BITS-ID : 2024ht01021

import os
import time
import serial  # For reading data from USB
import numpy as np
import matplotlib.pyplot as plt
import tkinter as tk
from tkinter import messagebox
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from fpdf import FPDF
from datetime import datetime

# Global variables to store ECG data and control the recording
x_data, y_data = [], []
all_x_data = []
all_y_data = []  # Continuous data for report
anomaly_report = []
recording = False
segment_length = 100  # Data points per segment in PDF

# Configure USB serial port (Adjust to your actual port)
# Ensure the port matches your device's port, e.g., COM3 on Windows or /dev/ttyUSB0 on Linux
ser = serial.Serial('/dev/ttyACM1', baudrate=9600, timeout=1)

# Function to read ECG data from USB
def read_ecg_from_usb():
    try:
        line = ser.readline().decode('utf-8').strip()  # Read line from serial
        if line.startswith('ECG:'):
            ecg_value = float(line.split('ECG: ')[1])  # Extract the value after "ECG:"
            return ecg_value
    except ValueError:
        print("Error reading data from USB")
        return None

# Function to detect heartbeat peaks
def detect_heartbeat(ecg_value):
    return ecg_value > 500  # Simple threshold for heartbeat

# Function to detect anomalies
def detect_anomaly(ecg_value):
    if ecg_value > 1600:  # Example threshold for anomalies
        return f"Anomaly Detected: ECG value {ecg_value} exceeds threshold"

# Function to update the real-time plot
def update_plot(frame):
    if recording:
        ecg_value = read_ecg_from_usb()
        if ecg_value is not None:
            current_time = time.time() - start_time  # Relative time

            # Update real-time plot data
            x_data.append(current_time)
            y_data.append(ecg_value)

            # Store full data for report generation
            all_x_data.append(current_time)
            all_y_data.append(ecg_value)

            if len(x_data) > 50:
                x_data.pop(0)
                y_data.pop(0)

            line.set_data(x_data, y_data)

            # Check for anomalies and heartbeats
            if detect_heartbeat(ecg_value):
                print(f"Heartbeat detected! ECG value: {ecg_value}")
            anomaly = detect_anomaly(ecg_value)
            if anomaly:
                print(anomaly)
                anomaly_report.append(f"{anomaly} at {time.strftime('%H:%M:%S')}\n")

            # Redraw the canvas
            ax.relim()
            ax.autoscale_view()
            canvas.draw()

    return line,

# Function to start recording ECG data
def start_recording():
    global recording, start_time
    recording = True
    start_time = time.time()
    print("Recording started...")

# Function to stop recording and generate report
def stop_recording():
    global recording
    recording = False
    print("Recording stopped.")
    generate_report()

# Function to generate a PDF report
def generate_report():
    patient_name = name_var.get()
    patient_age = age_var.get()
    patient_weight = weight_var.get()

    # Create a folder for the report
    date_str = datetime.now().strftime("%Y-%m-%d")
    patient_folder = f"{patient_name}_{date_str}"
    if not os.path.exists(patient_folder):
        os.makedirs(patient_folder)

    # Filename for PDF report
    report_filename = os.path.join(patient_folder, f"{patient_name}_ECG_Report.pdf")

    # Create PDF
    pdf = FPDF()
    pdf.add_page()

    # Add patient info to the PDF
    pdf.set_font("Arial", size=12)
    pdf.cell(200, 10, txt="ECG Anomaly Detection Report", ln=True, align="C")
    pdf.cell(200, 10, txt=f"Patient Name: {patient_name}", ln=True, align="L")
    pdf.cell(200, 10, txt=f"Patient Age: {patient_age}", ln=True, align="L")
    pdf.cell(200, 10, txt=f"Patient Weight: {patient_weight}", ln=True, align="L")
    pdf.cell(200, 10, txt=f"Date: {time.strftime('%Y-%m-%d')}", ln=True, align="L")
    pdf.cell(200, 10, txt=f"Total anomalies detected: {len(anomaly_report)}", ln=True, align="L")

    # Split the data into segments and add each segment to the PDF
    total_points = len(all_x_data)
    num_segments = total_points // segment_length

    y_offset = 80  # Offset for the y-position of each segment in the PDF

    for i in range(num_segments + 1):
        start_idx = i * segment_length
        end_idx = min(start_idx + segment_length, total_points)

        if start_idx < end_idx:
            # Create figure for the segment
            fig_segment, ax_segment = plt.subplots(figsize=(8, 2))
            ax_segment.plot(all_x_data[start_idx:end_idx], all_y_data[start_idx:end_idx], color='blue', lw=1)
            ax_segment.set_title(f"ECG Waveform Segment {i + 1}")
            ax_segment.set_xlabel("Time (seconds)")
            ax_segment.set_ylabel("ECG Value")
            ax_segment.grid(True)

            # Save the segment as an image
            segment_filename = os.path.join(patient_folder, f"ecg_segment_{i + 1}.png")
            fig_segment.savefig(segment_filename, bbox_inches='tight')

            # Add the image to the PDF
            pdf.image(segment_filename, x=10, y=y_offset, w=180)
            y_offset += 65  # Move the y-position down for the next segment

            # Add a new page if the y_offset exceeds page height
            if y_offset > 270:
                pdf.add_page()
                y_offset = 20

    # Add the anomalies to the PDF
    pdf.ln(120)
    pdf.multi_cell(0, 10, "\n".join(anomaly_report))

    # Add conclusion to the PDF
    pdf.ln(10)
    pdf.set_font("Arial", size=12, style='B')
    pdf.cell(200, 10, txt="Conclusion", ln=True, align="L")
    pdf.set_font("Arial", size=10)
    conclusion = f"The ECG data indicates {len(anomaly_report)} anomalies. Further medical review is recommended."
    pdf.multi_cell(0, 10, conclusion)

    # Save the PDF
    pdf.output(report_filename)
    print(f"Report saved: {report_filename}")
    messagebox.showinfo("Report", f"ECG report saved as {report_filename}")

# Set up the Tkinter GUI
root = tk.Tk()
root.title("ECG Monitoring System")

# Input fields for patient details
name_var = tk.StringVar()
age_var = tk.StringVar()
weight_var = tk.StringVar()

tk.Label(root, text="Patient Name:").pack()
tk.Entry(root, textvariable=name_var).pack()

tk.Label(root, text="Patient Age:").pack()
tk.Entry(root, textvariable=age_var).pack()

tk.Label(root, text="Patient Weight (kg):").pack()
tk.Entry(root, textvariable=weight_var).pack()

# Buttons to start and stop recording
start_button = tk.Button(root, text="Start Recording", command=start_recording)
start_button.pack(pady=10)

stop_button = tk.Button(root, text="Stop Recording & Generate Report", command=stop_recording)
stop_button.pack(pady=10)

# Set up the Matplotlib figure and axes for the real-time ECG plot
fig, ax = plt.subplots()
line, = ax.plot([], [], label='ECG Data', color='blue')

ax.set_title("Real-time ECG Monitoring")
ax.set_xlabel("Time (seconds)")
ax.set_ylabel("ECG Value")
ax.grid(True)

# Embed the plot in the Tkinter window
canvas = FigureCanvasTkAgg(fig, master=root)
canvas.get_tk_widget().pack(fill=tk.BOTH, expand=True)

# Animation to update the plot with incoming data
from matplotlib.animation import FuncAnimation
ani = FuncAnimation(fig, update_plot, interval=200)

# Start the Tkinter main loop
root.mainloop()
