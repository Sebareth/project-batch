@Echo off & cls
Mode con cols=72 lines=10
Title %Title%
cls


set Title=Desktop and Gaming _Close and Restart
set ExplorerExe=explorer.exe
:: :CHOICE1 = FULL Restart Explorer.exe
:: :CHOICE2 = When Explorer.exe is closed, Launch a Game.exe

:menuLOOP
echo.
echo.      ==========================Menu============================
echo.
echo            Manage your Desktop during your Gaming Session. 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.
echo.      ==========================================================
set option=
echo. & set /p option=Choose an option or hit ENTER to quit: || GOTO :EOF
echo. & call :menu_[%option%]
GOTO:menuLOOP

::********************************************************************************************
:menu_[1] Restart your Desktop
::********************************************************************************************
Title Restarting your Desktop
cls
set Kill=You choose to restart your desktop, this will take few seconds.
set Running=Success! Your desktop has been restarted.
set Fully=Your desktop is now fully loaded!

:CHOICE1
set /P Restart=Do you want to be FULL restart %ExplorerExe% [Y/N]?
if /I "%Restart%" EQU "Y" goto :RESTART
if /I "%Restart%" EQU "N" goto :menuLOOP
goto :CHOICE1

:RESTART
echo %Kill%
ping -n 5 127.0.0.1 >NUL 2>&1   
taskkill /F /IM %ExplorerExe% >NUL
echo.
ping -n 10 127.0.0.1 >NUL 2>&1   
echo.
start %ExplorerExe%>NUL
echo %Running%
echo.
ping -n 10 127.0.0.1 >NUL 2>&1   
echo.   
echo %Fully%
pause>NUL
goto :menuLOOP

::********************************************************************************************
:menu_[2] Choose your game
::********************************************************************************************
Title Choosing your game
cls
echo Please note that your Desktop will be closed during your gaming session, 
echo and will be restartedonce you finish your session

:CHOICE2
set /P LaunchGame=You will close %ExplorerExe%, and choose a game to launch [Y/N]?
if /I "%LaunchGame%" EQU "Y" goto :CLOSE
if /I "%LaunchGame%" EQU "N" goto :menuLOOP
goto :CHOICE2

::TODO: ***************************************************************************************
:CLOSE
Title Closing your Desktop
cls
set Kill1=You choose to close your desktop, and then choose a game to launch.
set Killed=Your desktop is now closed, please choose a game.
set Still=Your desktop is still closed!
set parm= is launched at full screen and high cpu priority,

echo.
echo %Kill1%
ping -n 5 127.0.0.1 >NUL 2>&1   
taskkill /F /IM %ExplorerExe% >NUL
echo.
echo %Killed%
set /p "MyGame=Type your game name> "
::set Available=witch callof neverwinter
echo.
Start "" /b /MAX /HIGH %MyGame%.exe>nul
echo %MyGame% %parm% %Still%
pause>nul
GOTO :menuLOOP

::********************************************************************************************
:menu_[3] Close your Desktop -only
::********************************************************************************************
Title Closing your Desktop -only
cls
echo.
echo Closing your desktop -only
ping -n 5 127.0.0.1 >NUL 2>&1   
taskkill /F /IM %ExplorerExe% >NUL
echo.
echo Your desktop is now closed.
goto :menuLOOT

::********************************************************************************************
:menu_[4] Turn off after X seconds
::********************************************************************************************
cls
title Check Status
SHUTDOWN /s /t 60 /c "Shutdown in progress, you have 60 seconds"
pause
::TODO 
:: - Donner la possibilité de choisir le nombre de secondes
:: - Dernière action ? Clean-up ?

::********************************************************************************************
:FIN
echo Cliquer sur une touche pour retourner au menu
pause>NUL
goto :EOF
EXIT
