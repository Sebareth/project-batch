@echo off & cls
Mode con cols=70 lines=10
Title %title_windows%

Set title_windows=%~n0
Set menu_text=Uninstall OneDrive
Set option_text=Choose an option or hit ENTER to quit:

:menuLOOP
echo.
echo.      ========================Menu============================
echo.
echo            		%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
GOTO OPTION

:OPTION
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%] || GOTO :OPTION
pause>NUL
::*****************************************************************
:menu_[1] Uninstall OneDrive
Set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
Set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
Set Title=Uninstalling OneDrive
cls
Title %Title%

echo Closing OneDrive process.
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1

echo Uninstalling OneDrive.
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1

echo Removing OneDrive leftovers.
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 

echo Removing OneDrive from the Explorer Side Panel.
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
