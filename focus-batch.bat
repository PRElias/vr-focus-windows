@echo off

set SCRIPT_NAME=focus.ps1
set SCRIPT_DIR=C:

powershell.exe -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File ""%SCRIPT_DIR%\%SCRIPT_NAME%"""' -Verb RunAs"
