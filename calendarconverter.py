import tkinter as tk
from tkinter import filedialog
from PIL import Image
import easyocr
import pandas as pd

def extract_timetable_from_image(image_path):
    # Initialize EasyOCR reader
    reader = easyocr.Reader(['en'])
    
    # Perform OCR on the image
    results = reader.readtext(image_path)

    # Process the results
    data = []
    for (bbox, text, prob) in results:
        if text.strip():  # Skip empty lines
            data.append(text.split())  # Split by whitespace

    return data

def save_to_csv(data, output_path):
    # Convert to DataFrame and then to CSV
    df = pd.DataFrame(data)
    df.to_csv(output_path, index=False)

def browse_image():
    # Open file dialog to select an image
    image_path = filedialog.askopenfilename(
        title="Select Timetable Image",
        filetypes=[("Image Files", "*.png;*.jpg;*.jpeg;*.bmp;*.gif")]
    )
    if image_path:
        process_image(image_path)

def process_image(image_path):
    data = extract_timetable_from_image(image_path)

    if not data:
        print("No data extracted from the image.")
        return

    output_path = filedialog.asksaveasfilename(
        title="Save CSV File",
        defaultextension=".csv",
        filetypes=[("CSV Files", "*.csv")]
    )

    if output_path:
        save_to_csv(data, output_path)
        print(f'Timetable extracted and saved as {output_path}')

def main():
    # Create the main application window
    root = tk.Tk()
    root.title("Timetable Extractor")
    root.geometry("300x150")

    # Create a button to browse for the image
    btn_browse = tk.Button(root, text="Upload Timetable Image", command=browse_image)
    btn_browse.pack(pady=20)

    # Start the application
    root.mainloop()

if __name__ == '__main__':
    main()
