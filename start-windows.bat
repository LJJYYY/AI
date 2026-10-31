@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Print Material Studio

echo.
echo ==========================================
echo   Print Material Studio - local launcher
echo ==========================================
echo.

where py >nul 2>&1
if not errorlevel 1 (
  set "PYTHON=py -3"
) else (
  where python >nul 2>&1
  if errorlevel 1 goto NO_PYTHON
  set "PYTHON=python"
)

if not exist ".venv\Scripts\python.exe" (
  echo Creating local Python environment...
  %PYTHON% -m venv .venv
  if errorlevel 1 goto FAILED
)

echo Installing/checking dependencies...
.venv\Scripts\python.exe -m pip install -r requirements.txt
if errorlevel 1 goto FAILED

echo.
echo Starting server...
echo Open http://127.0.0.1:8765 in your browser.
echo Close this window to stop the server.
echo.
.venv\Scripts\python.exe run.py --no-browser --port 8765
if errorlevel 1 goto FAILED
exit /b 0

:NO_PYTHON
echo Python 3 was not found.
echo Install Python from https://www.python.org/downloads/windows/
echo During setup, enable "Add python.exe to PATH".
goto PAUSE_FAIL

:FAILED
echo.
echo Startup failed. Read the error above.
:PAUSE_FAIL
echo.
pause
exit /b 1
