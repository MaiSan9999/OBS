@echo off
set "OBS_APPDATA=%APPDATA%\obs-studio"

REM Remove sentinel to prevent Safe Mode popup
if exist "%OBS_APPDATA%\.sentinel" (
    attrib -h -s "%OBS_APPDATA%\.sentinel" >nul 2>&1
    rmdir /s /q "%OBS_APPDATA%\.sentinel" >nul 2>&1
    del /f /q "%OBS_APPDATA%\.sentinel" >nul 2>&1
)

REM Start OBS
cd /d "C:\Program Files\obs-studio\bin\64bit"
start "" obs64.exe --disable-updater

REM Wait 10 seconds for OBS to fully load
timeout /t 10 /nobreak >nul

REM Focus OBS window (important for hotkeys)
powershell -command "$wshell = New-Object -ComObject WScript.Shell; $wshell.AppActivate('OBS')"

REM Small delay to ensure focus is locked
timeout /t 1 /nobreak >nul

REM Send Shift + F12
powershell -command "$wshell = New-Object -ComObject WScript.Shell; $wshell.SendKeys('+{F12}')"

exit