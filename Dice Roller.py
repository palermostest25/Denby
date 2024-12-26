import random
import time
min = int(input("Enter the minimum dice value:"))
max = int(input("Enter the maximum dice value:"))
print ("Rolling the dice...")
print ("The value is....")
print (random.randint(min, max))
time.sleep (10)

