@echo off
cls
title Shutdown in X seconds
::title %title%

:: Add question: You choose to shutdown your computer, choose X seconds [Y/N]:
:: set X=
:: set title=Shutdown in X seconds

SHUTDOWN /s /t 30 /c "Shutdown in progress, you have X seconds"
pause
