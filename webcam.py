import cv2

while True:
    try:
        capture = cv2.VideoCapture(int(input("Enter the ID of the Webcam to Capture- ")))
        break
    except:
        print("Please Enter a Valid Number...\n")
        pass

print("Please Wait...")
cv2.namedWindow("Capture from Webcam", cv2.WINDOW_NORMAL)

while True:
    _, frame = capture.read()
    cv2.imshow("Capture from Webcam", frame)
    if cv2.waitKey(1) == 27:
        break
    if cv2.getWindowProperty("Capture from Webcam", cv2.WND_PROP_VISIBLE) < 1:
        break

capture.release()
cv2.destroyAllWindows()