import pyautogui as pag
import pyautogui as pag
import random
import time

curr_coords = pag.position()
afk_counter = 0
while True:
    if pag.position() == curr_coords:
        afk_counter += 1
    else:
        afk_counter = 0
        curr_coords = pag.position()
    if afk_counter > 5:
        x = random.randint(100, 1820)
        y = random.randint(100, 980)
        print(f"Moving to: X: {x}, Y: {y}")
        pag.moveTo(x, y, 0.5)
        curr_coords = pag.position()
    print(f"AFK Counter: {afk_counter}")
    time.sleep(10)