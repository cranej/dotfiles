cd ~
$OutputEncoding = New-Object -typename System.Text.UTF8Encoding

function get-pwd-short {
	return "$pwd" -replace [regex]::escape($home), "~"
}

function prompt
{
    $l = "$(Get-Location)".Split("\")
    $title = "$(Get-Location)"
    if($l.Length -gt 2){
        $title = [String]::Join("\", $l[($l.Length-2)..$l.Length])
    }
    # Set Window Title
    $host.UI.RawUI.WindowTitle = "$title"
    #$host.UI.RawUI.WindowTitle = "Files: " + (get-childitem).count + " Process: " + (get-process).count
    
    # location stack
    $locStack = New-Object string ([char] '+'), (Get-Location -Stack).Count

    # Set Prompt
    #Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor Red
    #Write-Host " :: " -NoNewline -ForegroundColor DarkGray
    Write-Host "$ENV:USERNAME@$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Yellow
    Write-Host " :: " -NoNewline -ForegroundColor DarkGray
    Write-Host $(get-pwd-short) -NoNewLine -ForegroundColor Green
    Write-Host " $locStack" -ForegroundColor DarkGray 

    # Check for Administrator elevation
    $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp=new-object System.Security.Principal.WindowsPrincipal($wid)
    $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
    $IsAdmin=$prp.IsInRole($adm)
    if ($IsAdmin) {
        Write-Host "(admin) #" -NoNewline -ForegroundColor Gray

        return " "
    }
    else {
        Write-Host "$" -NoNewline -ForegroundColor Gray
        return " "
    }
 }

 function elevate {
    $command,$arguments=$args
    if($arguments){
        Start-Process "$command" -Verb runas -ArgumentList $arguments
    } else {
        Start-Process "$command" -Verb runas
    }
 }


# A "set" function that behaves more like the same
# command in cmd and bash.
function set-variableEx
{
	if ($args.Count -eq 0) { get-variable }
	elseif ($args.Count -eq 1) { get-variable $args[0] }
	else { invoke-expression "set-variable $args" }
}

$env:EDITOR = "gvim"
$env:VISUAL = $env:EDITOR
$env:GIT_EDITOR = $env:EDITOR

# Some helpers for working with the filesystem
function remove-allChildItems([string] $glob) { remove-item -recurse -force $glob }
function get-childfiles { get-childitem | ? { -not $_.PsIsContainer } }
function get-childcontainers { get-childitem | ? { $_.PsIsContainer } }
function get-command-path([string] $cmd) {
    get-command $cmd | % {
        if($_.CommandType -eq "Alias") { 
            $_.DisplayName 
        } elseif ($_.CommandType -eq "Application") {
            $_.Path
        } else {
            "[$($_.CommandType)]$($_.Name)"
        }
    } 
}

set-alias count measure-object
set-alias lsd get-childcontainers
set-alias lsf get-childfiles
set-alias rmd remove-allChildItems
if (test-path alias:\set) { remove-item alias:\set -force }
set-alias set set-variableEx -force
set-alias sudo elevate 
set-alias unset remove-variable
#set-alias whence get-commandInfoEx
set-alias which get-command-path

# Helper functions for user/computer session management
function invoke-userLogout { shutdown /l /t 0 }
function invoke-systemShutdown { shutdown /s /t 5 }
function invoke-systemReboot { shutdown /r /t 5 }
function invoke-systemSleep { RunDll32.exe PowrProf.dll,SetSuspendState }
function invoke-terminalLock { RunDll32.exe User32.dll,LockWorkStation }

# Aliases
set-alias logout invoke-userLogout
set-alias halt invoke-systemShutdown
set-alias restart invoke-systemReboot
if (test-path alias:\sleep) { remove-item alias:\sleep -force }
set-alias sleep invoke-systemSleep -force
set-alias lock invoke-terminalLock

#use gnudiff
if (test-path alias:\diff) { remove-item alias:\diff -force }
