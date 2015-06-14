@echo off & cls
Mode con cols=70 lines=10
Title %title%

Set title=%~n0
Set menu_text=Menu Example
Set option_text=Choose an option or hit ENTER to quit:

:menuLOOP
echo.
echo.      ========================Menu============================
echo.
echo            		%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
GOTO :OPTION

:OPTION
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%] || GOTO :OPTION
pause>NUL

:EOF
EXIT
