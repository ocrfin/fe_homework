@echo off
REM ==================================================
REM Quick Development Server Start Script
REM ==================================================
REM Use this script when dependencies are already installed
REM For first-time setup, use dev-setup.bat instead

setlocal EnableDelayedExpansion

REM Get script directory
set "SCRIPT_DIR=%~dp0"

echo 🚀 Starting Development Servers...
echo.

REM Kill any existing servers first
echo [INFO] Stopping any existing servers...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
timeout /t 1 /nobreak >nul

REM Start backend
echo [INFO] Starting Flask backend...
cd /d "%SCRIPT_DIR%backend"

REM Check if virtual environment exists
if not exist "venv" (
    echo [ERROR] Virtual environment not found. Please run dev-setup.bat first.
    pause
    exit /b 1
)

REM Start backend in background
start /B cmd /c "call venv\Scripts\activate.bat && python app.py > ..\backend.log 2>&1"
timeout /t 2 /nobreak >nul

REM Check if backend started (basic check by looking for python process)
tasklist /fi "imagename eq python.exe" | find "python.exe" >nul
if errorlevel 1 (
    echo [ERROR] Failed to start backend. Check backend.log
    pause
    exit /b 1
) else (
    echo [SUCCESS] Backend started on http://127.0.0.1:5000
)

REM Start frontend
echo [INFO] Starting Vue.js frontend...
cd /d "%SCRIPT_DIR%frontend"

REM Check if node_modules exists
if not exist "node_modules" (
    echo [ERROR] Node modules not found. Please run dev-setup.bat first.
    echo [INFO] Stopping backend...
    taskkill /f /im python.exe >nul 2>&1
    pause
    exit /b 1
)

REM Start frontend in background
start /B cmd /c "npm run dev > ..\frontend.log 2>&1"
timeout /t 3 /nobreak >nul

REM Check if frontend started (basic check by looking for node process)
tasklist /fi "imagename eq node.exe" | find "node.exe" >nul
if errorlevel 1 (
    echo [ERROR] Failed to start frontend. Check frontend.log
    echo [INFO] Stopping backend...
    taskkill /f /im python.exe >nul 2>&1
    pause
    exit /b 1
) else (
    echo [SUCCESS] Frontend started on http://127.0.0.1:5173 (typical)
)

echo.
echo 🎉 Both servers are running!
echo.
echo 📱 Frontend: http://127.0.0.1:5173 (check frontend.log for exact URL)
echo 🔧 Backend:  http://127.0.0.1:5000
echo.
echo 👤 Login with: admin/admin123 or demo/demo123
echo.
echo 📄 Logs: backend.log, frontend.log
echo 🛑 Close this window to stop servers (or use Ctrl+C)
echo.

REM Function to stop servers on exit
:cleanup
echo.
echo [INFO] Stopping servers...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
echo [SUCCESS] Development servers stopped
exit /b 0

REM Wait for user input to keep window open and servers running
echo Press any key to stop servers and exit...
pause >nul
goto cleanup