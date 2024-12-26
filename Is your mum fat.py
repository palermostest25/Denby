import os
os.system("title Is your mum fat?")
print("Is your mum fat?")
print("NOTE: Don\'t use any units.")
weight = float(input("Weight-"))
height = float(input("Height-"))
age = float(input("Age-"))
os.system("echo Press any key to process... && pause > nul")
if (weight) < 40:
    mum = "really not so"
if (weight) > 60:
    mum = "concerningly"
if (weight) < 40:
    mum = "really not so"
if (weight) > 80:
    mum = "humongously"

if (age) < 40:
    mum1 = "young"
if (age) > 60:
    mum1 = "old"
if (age) > 80:
    mum1 = "very old"

if (height) < 40:
    mum2 = "extremely very too short"
if (height) > 160:
    mum2 = "as tall as average"
if (height) > 175:
    mum2 = "very tall"

totalmummum1 = (f"Your mum is {mum1} and {mum2} and also {mum} fat.")
print(totalmummum1)
os.system("echo Press any key to exit... && pause > nul && exit")