import os
os.system("title L33T5P34K")
def l33tspeak(inputText):
    ledger = {
        'a':'4',
        'e':'3',
        'i':'1',
        'k':'|<',
        'l':'7',
        'o':'0',
        'p':'?',
        's':'$',
        't':'7',
    }
    outputText = ''
    for c in inputText:
        if c in ledger.keys():
            outputText = ''.join([outputText, ledger[c]])
        else:
            outputText = ''.join([outputText, c])
    return outputText

message = input("Message: ")
print(f'The L33T5P34K of {message} is "{l33tspeak(message)}"')
os.system("echo Press Any Key to Exit... && pause > nul")