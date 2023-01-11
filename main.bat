@echo off
rem Check if running as administrator
net session >nul 2>&1
if %errorlevel% == 0 (
   echo Running as administrator
) else (
   echo This script must be run as administrator
   exit /b
)

rem Disable firewall
netsh advfirewall set allprofiles state off

rem Check if firewall is disabled
netsh advfirewall show currentprofile | find "State" | find "Off" >nul
if %errorlevel% == 0 (
   echo Firewall is now disabled
) else (
   echo An error occurred while trying to disable the firewall
)
