:: please rename file path

@echo off
for /R %%f in (*.wav) do (
    "C:\Users\user\ffmpeg.exe" -i "%%f" -c:a aac -b:a 192k "%%~dpnf.m4a" 
    if not errorlevel 1 del "%%f"
)
pause