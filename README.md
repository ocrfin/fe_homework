# Server Dashboard Application

A full-stack server management application built with Flask (backend) and Vue 3 (frontend).

## Quick Start (Automated Setup)

### 🚀 One-Command Setup

**macOS/Linux:**
```bash
# For first-time setup (installs everything and starts servers)
./dev-setup.sh

# For daily development (when already set up)
./start-dev.sh
```

**Windows:**
```powershell
# PowerShell (Recommended - better error handling and output)
.\dev-setup.ps1    # For first-time setup
.\start-dev.ps1     # For daily development
```

> **💡 Windows Users:** PowerShell scripts (`.ps1`) are recommended over batch files (`.bat`) as they provide better error handling, colored output, and more robust process management. If you encounter execution policy issues, run: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force`

## Manual Installation & Setup

### Prerequisites
- Python 3.9+
- Node.js 20.19.0+ or 22.12.0+ (v21 is not supported)
- npm or yarn

### Backend Setup

#### Step 1: Navigate to the backend directory
```bash
cd ./backend
```

#### Step 2: Create a Python Virtual Environment
A virtual environment isolates your Python dependencies from your system Python installation.

**On macOS/Linux:**
```bash
# Create a virtual environment named 'venv'
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate
```

**On Windows:**
```bash
# Create a virtual environment named 'venv'
python -m venv venv

# Activate the virtual environment
venv\Scripts\activate
```

**Note:** After activation, you should see `(venv)` at the beginning of your terminal prompt, indicating the virtual environment is active.

#### Step 3: Install Python Dependencies
With the virtual environment activated, install the required packages:
```bash
pip install -r requirements.txt
```

#### Step 4: Start the Flask Development Server
```bash
python app.py
```

The backend will be available at `http://localhost:5000`

#### Deactivating the Virtual Environment
When you're done working on the project, you can deactivate the virtual environment:
```bash
deactivate
```

#### Future Development Sessions
For future development sessions, remember to activate the virtual environment before starting the server:
```bash
cd ./backend
source venv/bin/activate  # On macOS/Linux
# OR
venv\Scripts\activate     # On Windows
python app.py
```

### Frontend Setup
1. Navigate to the frontend directory:
   ```bash
   cd ./frontend
   ```

2. Install Node.js dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```
   
   The frontend will be available at `http://localhost:5173`

## Troubleshooting

### Common Issues

#### Virtual Environment Not Activating
- **Issue**: The `(venv)` prefix doesn't appear in your terminal
- **Solution**: Make sure you're in the `backend/` directory and running the correct activation command for your OS
- **Alternative**: Try using the full path: `source ./venv/bin/activate` (macOS/Linux)

#### "python3: command not found" Error
- **Issue**: Python 3 is not installed or not in your PATH
- **Solution**: 
  - On macOS: Install Python via [python.org](https://python.org) or use `brew install python3`
  - On Windows: Install Python from [python.org](https://python.org) and ensure "Add to PATH" is checked
  - Try using `python` instead of `python3`

#### "pip: command not found" Error
- **Issue**: pip is not installed or not accessible
- **Solution**: 
  - Try `pip3` instead of `pip`
  - On some systems, use `python -m pip` or `python3 -m pip`

#### Permission Denied Errors
- **Issue**: Permission errors when installing packages
- **Solution**: Make sure your virtual environment is activated before installing packages. Never use `sudo` with pip in a virtual environment.

#### Port Already in Use
- **Issue**: "Address already in use" error when starting the server
- **Solution**: 
  - Check if another instance is running: `lsof -i :5000` (macOS/Linux) or `netstat -ano | findstr :5000` (Windows)
  - Kill the existing process or use a different port

#### Dependencies Not Installing
- **Issue**: Errors during `pip install -r requirements.txt`
- **Solution**:
  - Ensure your virtual environment is activated
  - Update pip: `pip install --upgrade pip`
  - Try installing packages individually to identify the problematic one

#### Window script execution
- if you get an error running the .ps1 scripts you may need to run `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force` to allow your current user to run scripts

## Usage

### Demo Accounts
The application comes with pre-configured demo accounts:
- **Admin**: username `admin`, password `admin123`
- **Demo User**: username `demo`, password `demo123`


## Challenge

The challenge here is laid out as a series of tasks. The intent is to spend no more than 4 or 5 hours and accomplish as much as you can. It is not required (or expected) that you will accomplish all of the asks below, but work through them and accomplish what you can. Our goal is to see how you approach tasks and what type of solutions are presented.

If you are not able to complete tasks and would like to explain how you would approach them feel free to add a .md file that includes your explanations 

Please clone this repo to your local system (do _not_ fork or PR against this repo) and then create a new repo for it to point at (preferrably public) send us a link to that repo when you are ready to submit your work.

## Context

You are an engineer working for the latest startup in the infrastructure management space. Below you will find a list from your ticket management system of items assigned to you in the backlog. There is no stated priority on these, please tackle them in whatever order you feel most comfortable. 

## Backlog

### General QA/Bugs

We have noticed via internal QA or heard user reports of potential bugs and/or quality of life improvements that could be made throughout the system. While working through the tasks below, if you see things that are either broken or even just missing or not as you would expect, please feel free to catalog them as a list in a separate MD file. We do not expect all of them to be fixed, but would like to understand what you found/noticed while using the application and working on other tasks. If any items you find are things you see as fixable while doing other work, feel free to do so and leave a summary of what you found in the same MD file while noting an associated update was made.

### fe-101: Server List - Filtering/Sorting Support

We currently support the ability to view all servers your account is managing at `/servers/`. We would like to add in the capability to sort, search and filter that table.

* all columns should be sortable
* all columns should be searchable (free text)
* list should be able to be filtered on status, OS, and location

### fe-102: Server List - Server Tile Display

We currently support the ability to view all servers your account is managing at `/servers/`. We would like to add an optional tile view.

* server list view should have a toggle control that allows the view to be either the table or grid of tiles
* our designer is fully committed to other work so show us your best design sense as you set up these tiles

### fe-103: Dashboard - Active Filtering

Our main dashboard view gives summary counts for each status. We would like to make those boxes clickable and filter the list of servers in "Recent Servers" by that status.

### fe-104: Dashboard - Server Health

We want to improve our management capability by adding more details on server health, please add details about server health based on the following criteria

* Healthy - memory && CPU && disk < 60%
* Unstable - (CPU || memory || disk > 60%) && all < 80%
* Unhealthy/Needs Attention - (all above 75%) || (any two above 80%) || (any one above 90%)

