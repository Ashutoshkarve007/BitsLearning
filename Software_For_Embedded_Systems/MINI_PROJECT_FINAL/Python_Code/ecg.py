from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

# Function to generate the PDF report using reportlab
def save_report():
    # Create a new canvas for the PDF
    c = canvas.Canvas("ecg_report.pdf", pagesize=letter)
    width, height = letter

    # Title
    c.setFont("Helvetica-Bold", 16)
    c.drawString(100, height - 50, "ECG Anomaly Detection Report")

    # Date
    c.setFont("Helvetica", 12)
    c.drawString(100, height - 80, "Date: {}".format(time.strftime('%Y-%m-%d')))

    # Total anomalies detected
    c.drawString(100, height - 110, "Total anomalies detected: {}".format(len(anomaly_report)))

    # ECG Plot (adding the saved image)
    c.drawImage("ecg_plot.png", 100, height - 450, width=400, height=300)

    # Anomalies detected
    text = c.beginText(100, height - 500)
    text.setFont("Helvetica", 12)
    text.textLines("\n".join(anomaly_report))
    c.drawText(text)

    # Conclusion
    text = c.beginText(100, height - 600)
    text.setFont("Helvetica-Bold", 14)
    text.textLine("Conclusion")
    text.setFont("Helvetica", 12)
    conclusion = "The ECG data indicates {} anomalies detected. Further medical review is recommended.".format(len(anomaly_report))
    text.textLines(conclusion)
    c.drawText(text)

    # Save the PDF
    c.save()
    print("Report generated: ecg_report.pdf")
    messagebox.showinfo("Report", "ECG report saved as ecg_report.pdf")
