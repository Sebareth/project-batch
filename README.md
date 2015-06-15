# project-batch


# All-in-One script

Windows Power Settings	----> main_powersettings.bat
This script requires Administrative permissions (stand_permissions.bat).
It will allow users to control Windows Power Settings after X seconds,
also type X to cancel any previous actions :
+ Sleep
+ Shutdown
+ Restart
+ Close session
+ Refresh desktop (explorer.exe)

Problems:
+ Refresh desktop: Need to cleanup/optimize script, need to detect if explorer.exe is running, set wait time to 25s

