@Echo off & cls
Mode con cols=72 lines=10

Set Title=Skype Starter and Killer
Set TmpFile=TmpFile.txt
Set Resultat=KillResult.txt
If Exist %TmpFile% Del %TmpFile%
If Exist %Resultat% Del %Resultat%

set SkypeExe=Skype.exe
set SkypeName=Skype
set SkypeUsername=Username
set SkypePassword=Password
set SkypeLogin=/username:%SkypeUsername% /password:%SkypePassword% /nosplash /minimized

:menulOOP
cls
Title %Title%
echo.
echo.      ==========================Menu============================
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.
echo.      ==========================================================
set option=
echo. & set /p option=Choose an option or hit ENTER to quit: || GOTO :EOF
echo. & call :menu_[%option%]
goto :menuLOOP

:menu_[1] Skype Status AND AutoConnect
cls
Title  %SkypeName% Status...
echo Checking if %SkypeName% is running or not...
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %SkypeExe%"') DO IF %%x == %SkypeExe% goto FOUND
echo %SkypeName% is not running.
echo Type any key to launch "%SkypeName%"
pause>nul
echo Launching %SkypeName%...
start "" /b /min /LOW %SkypeExe% /nosplash /minimized >nul
ping 192.0.2.2 -n 1 -w 5000>nul 2>nul
goto FOUND
goto CHOICE


:CHOICE
cls
Title AutoConnecting
set /P Want2Connect=Connect with %SkypeUsername% [Y/N]?
if /I "%Want2Connect%" EQU "Y" goto :AutoConnect
if /I "%Want2Connect%" EQU "N" goto :FIN
goto CHOICE

:AutoConnect
cls
Title AutoConnecting with %SkypeUsername%
echo Killing any instance of %SkypeName%
%SkypeExe% /Shutdown
pause>nul
echo.
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %SkypeExe%"') DO IF %%x == %SkypeExe% goto FOUND
start "" /b /min /LOW %SkypeExe% %SkypeLogin% >nul
echo Connecting to %SkypeName% with %SkypeUsername%
ping 192.0.2.2 -n 1 -w 3000>nul 2>nul
goto CONNECTED

:CONNECTED
cls
echo You are now connected to %SkypeUsername%
pause>nul
goto :menuLOOP

:FOUND
cls
echo %SkypeName% is running.
goto :CHOICE

:FIN
echo Cliquer sur une touche pour retourner au menu
pause>nul
goto :menuLOOP


::TODO NEED TO WORK ON THIS *****************************************************************
:menu_[2] StartMyProcess
cls
Title Start Available programs
echo.
echo                Choose which program you want to run ?
echo.
Set /p "MyProcess=Write program name to run without extension> "
set Available=Calc Chrome Notepad Skype
echo Programs who can be started: %Available%
echo.
Start "" /b /min /LOW %MyProcess%.exe>nul
echo %MyProcess% is launched.
pause>nul
goto :menuLOOP

:menu_[3] KillMyProcess
cls
Title Kill Available programs
echo.
echo                Choose which program you want to kill ?
echo.
set/p "process=Write program name to kill without extension> "
set Available=Calc Chrome Notepad Skype
echo Programs who can be killed: %Available%
Title Killing "%process%" ...
echo.
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %process%"') DO IF %%x == %process% goto FOUND
echo %process% is not running.
echo.
echo %date% *** %time% >> %TmpFile%
For %%a in (%process%) Do Call :KillMyProcess %%a
Cmd /U /C Type %TmpFile% > %Resultat%
Start %Resultat%
goto :menuLOOP

:KillMyProcess
Taskkill /IM "%~1.exe" /F >> %TmpFile% 2>&1 >nul
echo ***************************************************************************** >> %TmpFile%
exit /b 

:EOF
EXIT
