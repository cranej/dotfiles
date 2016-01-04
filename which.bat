:: Copyright: http://superuser.com/a/412981 by mbu(http://superuser.com/users/116096/mbu) 

@echo off
setlocal enabledelayedexpansion

set ext= ;%PATHEXT%
:extloop1
for /f "delims=; tokens=1,*" %%A in ("!ext!") do (
  if exist %1%%A (
    echo .\%1%%A
    goto finish
  )
  set ext=%%B
)
if "!ext!" neq "" goto extloop1

set ext= ;%PATHEXT%
:extloop2
for /f "delims=; tokens=1,*" %%A in ("!ext!") do (
  for %%C in (%1%%A) do (
    if exist %%~$PATH:C (
      echo %%~$PATH:C
      goto finish
    )
  )
  set ext=%%B
)
if "!ext!" neq "" goto extloop2

:finish
endlocal
