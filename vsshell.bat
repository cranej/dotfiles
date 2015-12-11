@echo off
SETLOCAL
SET INITFILEPATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat
echo. 
echo Loaded %INITFILEPATH% 
echo To unload, run Exit
IF NOT "%MYPROMPT%"=="" prompt [%COMPUTERNAME%] $p$S$+$_Visual$SStudio$g$S
%comspec% /k "%INITFILEPATH%"
IF NOT "%MYPROMPT%"=="" prompt %MYPROMPT%
ENDLOCAL
