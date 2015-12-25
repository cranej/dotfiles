@echo off
SET PATH=%USERPROFILE%\vimfiles\bin;%USERPROFILE%\bin;%PATH%

IF NOT "%VS140COMNTOOLS%"=="" (
    call :includevs14
    GOTO :NEXT
)

IF NOT "%VS120COMNTOOLS%"=="" (
    call :includevs12
    GOTO :NEXT
)

IF NOT "%VS110COMNTOOLS%"=="" (
    call :includevs11
    GOTO :NEXT
)

:includevs14
    SET VSPATH="%VS140COMNTOOLS:~0,-6%IDE\"
    SET PATH=%VSPATH%;%PATH% 
:end

:includevs12
    SET VSPATH="%VS120COMNTOOLS:~0,-6%IDE\"
    SET PATH=%VSPATH%;%PATH% 
:end

:includevs11
    SET VSPATH="%VS110COMNTOOLS:~0,-6%IDE\"
    SET PATH=%VSPATH%;%PATH% 
:end

:NEXT
SET MYPROMPT=[%COMPUTERNAME%] $p$S$+$_$g$S
SET PROMPT=%MYPROMPT%
TITLE I'm a shell ^^_^^     -    Extensions: vsshell, mbshell
