@echo off
Title AUTO Nettoyage CCLeaner et Fermeture
Mode con cols=72 lines=10

Set CCleaner64=CCleaner64.exe
Set CCleanerName=CCleaner

:menuLOOP
echo.
echo.      ==========================Menu============================
echo.
echo		              AUTO clean-up with CCLeaner
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.
echo.      ==========================================================
set option=
echo. & set /p option=Choose an option or hit ENTER to quit: || GOTO :EOF
echo. & call :menu_[%option%]
GOTO:menuLOOP
::*********************************************************************************
:menu_[1] Clean up
Title  %CCleanerName% Status...
cls
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %CCleaner64%"') DO IF %%x == %CCleaner64% goto FOUND
echo %CCleanerName% is not running.
echo Cliquer sur une touche pour lancer "%CCleanerName%"
pause>nul
echo Launching %CCleaner64%...
start "" /b /LOW %CCleaner64%>nul
ping 192.0.2.2 -n 1 -w 5000>nul 2>nul
goto FOUND
goto CONFIRM

:CONFIRM
cls
Title Do you want to clean up your computer ?

set /P Confirm=Confirm to clean up with %CCleanerName% [Y/N]?
if /I "%Restart%" EQU "Y" goto :CLEANUP
if /I "%Restart%" EQU "N" goto :menuLOOP
goto CONFIRM

:CLEANUP
cls
Title %CCleanerName% is starting to clean up your computer.

Set DossierCCleaner="%ProgramFiles%\CCleaner\"
pushd %DossierCCleaner%
start "" /b /LOW %CCleaner64% /AUTO >nul
popd
pause>nul
goto:menuLOOP

:CLOSING
cls
Title Do you want to close %CCleanerName% ?

set /P Closing=Confirm to close %CCleanerName% [Y/N]?
if /I "%Restart%" EQU "Y" goto :menu_[2] Close
if /I "%Restart%" EQU "N" goto :menuLOOP
goto CLOSING

::*********************************************************************************
:menu_[2] Close
cls
Title Closing %CCleanerName%
taskkill /F /IM %CCleaner64%>NUL
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %CCleaner64%"') DO IF %%x == %CCleaner64% goto FOUND
echo %CCleanerName% is not running.
pause>nul
goto:menuLOOP
::*********************************************************************************

:CLOSED
echo %CCleanerName% is closed now.
pause>nul
goto:menuLOOP

:FOUND
echo %CCleanerName% is running.
pause>nul
goto:menuLOOP

:FIN
echo Cliquer sur une touche pour retourner au menu principale.
pause>nul
GOTO:menuLOOP

:EOF
EXIT
::*********************************************************************************