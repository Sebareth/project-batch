@echo off & cls
Mode con cols=72 lines=10
::*********************************************************************************
Set program_name=OneDrive
Set program_exe=OneDrive.exe
Set menu_text=Uninstall %program_name%
Set option_text=Choose an option or hit ENTER to quit:
::*********************************************************************************
:menuLOOP
echo.
echo.      ========================Menu============================
echo.
echo            		%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
goto OPTION

:OPTION
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%] || GOTO :OPTION
pause>NUL
::*****************************************************************
:menu_[1] Uninstall OneDrive
Set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
Set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
Set Title=Uninstalling %program_name%
cls
Title %Title%

echo Closing %program_name% process.
echo.
taskkill /f /im %program_exe% > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1

echo Uninstalling %program_name%.
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1

echo Removing %program_name% leftovers.
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 

echo Removing %program_name% from the Explorer Side Panel.
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
pause>NUL

:menu_[2] Cleanup missing directories/files (not available)
goto NOTYET
::pause>nul

:NOTYET
Set notyet=Feature not yet available
cls
echo This feature is not yet available. Work in progress
echo You will be redirected to main menu.
pause
goto:menuLOOP

::EOF
::EXIT
