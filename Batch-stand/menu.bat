@Echo off & cls
Mode con cols=72 lines=10

set menu_text=Test titre menu
set option_text=Choose an option or hit ENTER to quit:
set option_incorrect=Please choose an option:

:menuLOOP
echo.
echo.      ========================Menu============================
echo.
echo            		%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.
echo.      ========================================================
GOTO :OPTION

:OPTION
set option=
echo. & set /p option=%option_text% || GOTO :EOF 2>NUL>NUL
echo. & call :menu_[%option%] ||
pause>NUL
::GOTO:menuLOOP

:EOF
EXIT
