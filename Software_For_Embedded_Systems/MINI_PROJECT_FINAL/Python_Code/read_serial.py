import serial  # Import the pySerial library
import time

# Configure the serial port (adjust to your actual port)
# On Windows, it might be COM3, COM4, etc.
# On Linux/macOS, it might be /dev/ttyUSB0 or /dev/ttyACM0
port = '/dev/ttyACM0'  # Change this to match your port
baudrate = 9600        # Ensure this matches the STM32 configuration

try:
    # Open the serial port
    ser = serial.Serial(port, baudrate, timeout=1)
    print(f"Connected to {port} at {baudrate} baud.")
except serial.SerialException:
    print(f"Failed to connect to {port}. Check the port name and connection.")
    exit()

# Continuously read and print data from the serial port
try:
    while True:
        if ser.in_waiting > 0:
            # Read a line of data from the STM32
            data = ser.readline().decode('utf-8').strip()
            if data:
                print(f"Received: {data}")
            else:
                print("No data received.")
        time.sleep(0.1)  # Delay to avoid busy-waiting
except KeyboardInterrupt:
    print("Exiting program.")
finally:
    # Close the serial port before exiting
    ser.close()
