@echo off
title Upload to Github
set /p "commitmessage=Commit Message: "
git add .
git commit -m "%commitmessage%"
git push -u origin main
pause