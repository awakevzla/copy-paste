@echo off
REM Batch script to start server + manager on Windows

echo.
echo ========================================
echo   Clipboard Manager Launcher
echo ========================================
echo.

REM Check if Node is installed
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)

REM Setup configuration from .env
echo [1/3] Generating configuration...
node setup-config.js
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to generate configuration
    pause
    exit /b 1
)

echo [2/3] Starting Node.js server...
echo.

REM Start server in new window
start cmd /k npm start

REM Wait for server to start
timeout /t 3 /nobreak

echo.
echo [3/3] Starting Clipboard Manager...
echo.

REM Find AutoHotkey - check v2 directory first
if exist "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe" (
    set AHK_PATH=C:\Program Files\AutoHotkey\v2\AutoHotkey.exe
    goto :run_ahk
)

if exist "C:\Program Files\AutoHotkey\AutoHotkey.exe" (
    set AHK_PATH=C:\Program Files\AutoHotkey\AutoHotkey.exe
    goto :run_ahk
)

if exist "C:\Program Files (x86)\AutoHotkey\AutoHotkey.exe" (
    set AHK_PATH=C:\Program Files (x86)\AutoHotkey\AutoHotkey.exe
    goto :run_ahk
)

REM AutoHotkey not found
echo ERROR: AutoHotkey is not installed
echo Download from: https://www.autohotkey.com/
pause
exit /b 1

:run_ahk
echo Found AutoHotkey at: %AHK_PATH%
start "" "%AHK_PATH%" "%~dp0scripts\clipboard-hotkey.ahk"
goto :end

:end
pause
