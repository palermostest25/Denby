@echo off
set /p "githubpath=What is the Path to the GitHub Project? [C:\...]- "
cd %githubpath%
set /p "commit=Enter Your Commit Comment: "
git add .
git commit -m %commit%
git push
pause