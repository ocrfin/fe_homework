@echo off
REM ==================================================
REM Full-Stack Development Environment Setup Script
REM ==================================================
REM This script sets up and runs the Vue.js + Flask application
REM with all dependencies and development servers

setlocal EnableDelayedExpansion

REM Color codes (limited in batch)
set "RED=echo."
set "GREEN=echo."
set "YELLOW=echo."
set "BLUE=echo."
set "PURPLE=echo."
set "CYAN=echo."

REM Get script directory
set "SCRIPT_DIR=%~dp0"
set "BACKEND_DIR=%SCRIPT_DIR%backend"
set "FRONTEND_DIR=%SCRIPT_DIR%frontend"

REM Check if we're in the right directory
if not exist "%BACKEND_DIR%" (
    echo [ERROR] Backend directory not found!
    echo [ERROR] Please run this script from the project root directory.
    pause
    exit /b 1
)

if not exist "%FRONTEND_DIR%" (
    echo [ERROR] Frontend directory not found!
    echo [ERROR] Please run this script from the project root directory.
    pause
    exit /b 1
)

echo.
echo ==================================================
echo 🚀 Full-Stack Development Setup
echo ==================================================
echo This script will:
echo 1. Check system requirements
echo 2. Set up Python virtual environment for backend
echo 3. Install Python dependencies
echo 4. Set up Node.js environment for frontend
echo 5. Install npm dependencies
echo 6. Initialize database with sample data
echo 7. Start both development servers
echo.

REM Ask for confirmation
set /p "REPLY=Continue with setup? (y/N): "
if /i not "%REPLY%"=="y" (
    echo [INFO] Setup cancelled.
    pause
    exit /b 0
)

REM ==================================================
REM SYSTEM REQUIREMENTS CHECK
REM ==================================================
echo.
echo ==================================================
echo 🔍 Checking System Requirements
echo ==================================================

REM Check Python
echo [STEP] Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH.
    echo [ERROR] Please install Python 3.9+ from https://python.org
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('python --version 2^>^&1') do set "PYTHON_VERSION=%%i"
    echo [SUCCESS] Found: !PYTHON_VERSION!
)

REM Check pip
echo [STEP] Checking pip installation...
pip --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] pip is not installed or not in PATH.
    pause
    exit /b 1
) else (
    echo [SUCCESS] pip is available
)

REM Check Node.js
echo [STEP] Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed or not in PATH.
    echo [ERROR] Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version 2^>^&1') do set "NODE_VERSION=%%i"
    echo [SUCCESS] Found: Node.js !NODE_VERSION!
)

REM Check npm
echo [STEP] Checking npm installation...
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] npm is not installed or not in PATH.
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm --version 2^>^&1') do set "NPM_VERSION=%%i"
    echo [SUCCESS] Found: npm v!NPM_VERSION!
)

REM ==================================================
REM BACKEND SETUP
REM ==================================================
echo.
echo ==================================================
echo 🐍 Setting up Backend (Python Flask)
echo ==================================================

cd /d "%BACKEND_DIR%"

REM Create virtual environment if it doesn't exist
echo [STEP] Setting up Python virtual environment...
if not exist "venv" (
    echo [INFO] Creating virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment
        pause
        exit /b 1
    )
    echo [SUCCESS] Virtual environment created
) else (
    echo [INFO] Virtual environment already exists
)

REM Activate virtual environment and install dependencies
echo [STEP] Installing Python dependencies...
call venv\Scripts\activate.bat

REM Upgrade pip first
python -m pip install --upgrade pip

REM Install requirements
if exist "requirements.txt" (
    pip install -r requirements.txt
    if errorlevel 1 (
        echo [ERROR] Failed to install Python dependencies
        pause
        exit /b 1
    )
    echo [SUCCESS] Python dependencies installed
) else (
    echo [ERROR] requirements.txt not found in backend directory
    pause
    exit /b 1
)

REM ==================================================
REM FRONTEND SETUP
REM ==================================================
echo.
echo ==================================================
echo 🌐 Setting up Frontend (Vue.js)
echo ==================================================

cd /d "%FRONTEND_DIR%"

REM Install Node.js dependencies
echo [STEP] Installing Node.js dependencies...
if exist "package.json" (
    npm install
    if errorlevel 1 (
        echo [ERROR] Failed to install Node.js dependencies
        pause
        exit /b 1
    )
    echo [SUCCESS] Node.js dependencies installed
) else (
    echo [ERROR] package.json not found in frontend directory
    pause
    exit /b 1
)

REM ==================================================
REM DATABASE INITIALIZATION
REM ==================================================
echo.
echo ==================================================
echo 🗄️ Initializing Database
echo ==================================================

cd /d "%BACKEND_DIR%"
call venv\Scripts\activate.bat

echo [STEP] Initializing SQLite database with sample data...
python -c "from app import app, db, create_sample_data; app.app_context().push(); db.create_all(); create_sample_data(); print('Database initialized successfully!')"
if errorlevel 1 (
    echo [ERROR] Failed to initialize database
    pause
    exit /b 1
)
echo [SUCCESS] Database initialized with sample data

REM ==================================================
REM START DEVELOPMENT SERVERS
REM ==================================================
echo.
echo ==================================================
echo 🚀 Starting Development Servers
echo ==================================================

REM Start backend server
echo [STEP] Starting Flask backend server...
cd /d "%BACKEND_DIR%"
call venv\Scripts\activate.bat
start /B python app.py > ..\backend.log 2>&1

REM Wait for backend to start
timeout /t 3 /nobreak >nul

echo [SUCCESS] Backend server started
echo [INFO] Backend running at: http://127.0.0.1:5000
echo [INFO] Backend logs: backend.log

REM Start frontend server
echo [STEP] Starting Vue.js frontend server...
cd /d "%FRONTEND_DIR%"
start /B npm run dev > ..\frontend.log 2>&1

REM Wait for frontend to start
timeout /t 5 /nobreak >nul

echo [SUCCESS] Frontend server started
echo [INFO] Frontend running at: http://127.0.0.1:5173 (typical)
echo [INFO] Frontend logs: frontend.log

REM ==================================================
REM SUCCESS MESSAGE
REM ==================================================
echo.
echo ==================================================
echo 🎉 Setup Complete!
echo ==================================================

echo Both development servers are running!
echo.
echo 📱 Frontend: http://127.0.0.1:5173 (check frontend.log for exact URL)
echo 🔧 Backend:  http://127.0.0.1:5000
echo.
echo 👤 Demo Accounts:
echo    Admin: username='admin', password='admin123'
echo    User:  username='demo', password='demo123'
echo.
echo 📄 Log Files:
echo    Backend: backend.log
echo    Frontend: frontend.log
echo.
echo 🛠️ Available Commands:
echo    View backend logs: type backend.log
echo    View frontend logs: type frontend.log
echo    Stop servers: Close this window or use Ctrl+C
echo.

REM Ask to open browser
set /p "REPLY=Open application in browser? (y/N): "
if /i "%REPLY%"=="y" (
    start http://127.0.0.1:5173
)

echo [INFO] Press any key to stop both servers
echo [INFO] Or close this window to keep servers running in background
pause

REM Note: In Windows batch, background processes continue running even after script ends
echo [INFO] Servers may continue running in background
echo [INFO] Check Task Manager to stop them if needed