@echo off
setlocal
cd /d "%~dp0"
echo Preparation des extensions MyPeugeot OAuth...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\build.ps1"
set "RESULT=%ERRORLEVEL%"
if not "%RESULT%"=="0" (
  echo.
  echo ECHEC de la construction. Code : %RESULT%
) else (
  echo.
  echo Construction terminee avec succes.
)
echo.
pause
exit /b %RESULT%
