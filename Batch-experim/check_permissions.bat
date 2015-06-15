@echo off
Mode con cols=75 lines=15
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		goto message
    ) else (
        echo Failure: Current permissions inadequate. 
		goto EOF
		
    )

:message
echo CONTINUE
pause>nul

:EOF
pause>nul
EXIT /B
	