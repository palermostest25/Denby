import moviepy.editor as moviepy
import os
os.system("title Video Converter")

inputext = input("Enter the Input File Name Extension(eg. '.avi'): ")
print(f"Put the video in the same directory as this file and name it 'video{inputext}'")
outputext = input("Enter the Output File Name Extension(eg. '.mp4'): ")
print("Noted.")
os.system('pause')

try:
    clip = moviepy.VideoFileClip(f"video{inputext}")
    clip.write_videofile(f"video{outputext}")
    os.system("echo Press any key to exit... && pause > nul && exit")
except Exception:
    print("Couldn't find the provided video.")
    os.system("echo Press any key to exit... && pause > nul && exit")
