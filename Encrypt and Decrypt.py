import os
os.system("title Encrypt/Decrypt")
count = 0
while count < 1:
    print("1. Encrypt\n2. Decrypt")
    encrypt = input("Would You Like to Encrypt or Decrypt? [1/2]: ")
    if encrypt == "1":
        encrypt = 1
        count = 2
    elif encrypt == "2":
        encrypt = 2
        count = 2
    else:
        print("")
        print("Invalid Option!")
if encrypt == 1:
    inputText = input('Message to Encrypt: ')
if encrypt == 2:
    inputText = input('Message to Decrypt: ')
key = input("Key (Default 5): ")
if len(key) == 0:
    key = 5
else:
    key = int(key)
if encrypt == 1:
    mode = 'encrypt'
if encrypt == 2:
    mode = 'decrypt'
ledger = 'abcdefghijklmnopqrstuvwxyz 1234567890'
outputText = ''
for char in inputText:
    inputIndex = ledger.find(char)
    if mode == 'encrypt':
        outputIndex = inputIndex + key
    elif mode == 'decrypt':
        outputIndex = inputIndex - key
    if outputIndex >= len(ledger):
        outputIndex = outputIndex - len(ledger)
    elif outputIndex < 0:
        outputIndex = outputIndex + len(ledger)
    outputText = outputText + ledger[outputIndex]
if encrypt == 1:
    print(f"Encrypted Message: {outputText}")
if encrypt == 2:
    print(f"Decrypted Message: {outputText}")
os.system("echo Press Any Key to Exit... && pause > nul")