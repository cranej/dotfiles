@echo off
SETLOCAL
SET INITFILEPATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsMSBuildCmd.bat
echo.
echo Loaded %INITFILEPATH% 
echo To unload, run Exit
IF NOT "%MYPROMPT%"=="" prompt [%COMPUTERNAME%] $p$S$+$_MSBuild$g$S
%comspec% /k "%INITFILEPATH%"
IF NOT "%MYPROMPT%"=="" prompt %MYPROMPT%
ENDLOCAL
