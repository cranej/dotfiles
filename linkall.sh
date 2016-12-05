#! /bin/sh
FROM=$HOME/workspace/dotfiles
TO=$HOME

ln -s $FROM/.Xdefaults $TO/.Xdefaults
ln -s $FROM/.ctags $TO/.ctags
ln -s $FROM/.msmtprc $TO/.msmtprc
ln -s $FROM/.mutt $TO/.mutt
ln -s $FROM/.offlineimaprc $TO/.offlineimaprc
ln -s $FROM/.xinitrc $TO/.xinitrc
ln -s $FROM/.profile $TO/.bash_profile
ln -s $FROM/.profile $TO/.zprofile
ln -s $FROM/.zshrc $TO/.zshrc
ln -s $FROM/gitglobalconfig $TO/.gitconfig
ln -s $FROM/vimrc $TO/.vimrc
ln -s $FROM/s.sh $TO/s.sh
ln -s $FROM/battery_monitor_loop.sh $TO/battery_monitor_loop
ln -s $FROM/i3 $TO/.config/i3
ln -s $FROM/tmux.conf $TO/.tmux.conf
