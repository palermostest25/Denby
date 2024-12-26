# Importing Library
from PIL import Image
import os

os.system("title Image Converter")
# Loading the image
inputext = input("Enter the Input File Name Extension(eg. '.png'): ")
print(f"Put the image in the same directory as this file and name it 'image{inputext}'")
outputext = input("Enter the Output File Name Extension(eg. '.ico'): ")
print("Noted.")
os.system('pause')

try:
    image = Image.open(f'image{inputext}')
    # Specifying the RGB mode to the image
    image = image.convert('RGB')
 
    # Converting an image from PNG to JPG format
    image.save(f"converted-image{outputext}")
    print("Image successfully converted!")
    os.system("echo Press any key to exit... && pause > nul && exit")
except FileNotFoundError:
    print("Couldn't find the provided image")
    os.system("echo Press any key to exit... && pause > nul && exit")
