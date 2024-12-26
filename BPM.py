import time
try:
    input("Press Enter to Start")
    start = time.time()
    input("Press Enter to Add Another Beat")
    end = time.time()
    final = end - start
    bpm = round((60/final), 2)
    while True:
        try:
            start = time.time()
            input(f"Press Enter to Add Another Beat [BPM: {bpm}]")
            end = time.time()
            final = end - start
            bpm = round((60/final), 2)
        except KeyboardInterrupt:
            print(f'\nFinal BPM: {bpm}')
            exit()
except KeyboardInterrupt:
    print(f'\nFinal BPM: {bpm}')

#start = time.time()
#input("Press Enter to Add Another Beat")
#end = time.time()
#final2 = end - start

#timebetweenbeat = max(final1, final2) - min(final1, final2)
#print(timebetweenbeat)
#print(f'BPM: {60/final}')