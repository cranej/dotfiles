# dotfiles ##
Keep dot files and utility tools simple and synced up. 

## vimrc ##
Modified based on Amir Salihefendic's version. See the comments at beginning of the file if you want a advanced version.

I added MarkdownPreview function and bind to `<leader>mc`, to use this feature you need `pandoc` installed and available on your path .

Backup your `.vimrc` file and run `cd ~ && curl https://raw.githubusercontent.com/cranej/dotfiles/master/vimrc > .vimrc`  

##env.bat##
Windows Command Prompt prompt customization, and newest `devenv.exe` in path if exists.  Set your Command Prompt shortcut's target to `%windir%\system32\cmd.exe /k  %userprofile%\workspace\dotfiles\env.bat` to load it on start.  

##mbshell.bat##
MSBuild shell. Put this file in path, and run `mbshell` to enter MSBuild shell.

##vsshell.bat##
Developer Command Prompt for Visual Studio 2015.  Put it in path and run 'vsshell' to enter. 

##which.bat##
`which` command for Windows Command Prompt. 

##Elevate.exe##
`sudo` for Windows Command Prompt. Run it without parameter to show help. 

You can compile it from [Source](https://github.com/cranej/elevate) after review it in detail if you don't trust me. 
