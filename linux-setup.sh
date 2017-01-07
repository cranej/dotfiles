#! /bin/sh
FROM=$HOME/workspace/dotfiles
TO=$HOME

blue='\033[0;34m'
light_blue='\033[1;34m'
green='\033[0;32m'
light_green='\033[1;32m'
cyan='\033[0;36m'
light_cyan='\033[1;36m'
purple='\033[0;35m'
light_purple='\033[1;35m'
yellow='\033[0;33m'
light_yellow='\033[1;33m'
red='\033[0;31m'
light_red='\033[1;31m'
end='\033[0m'

ln -s $FROM/.Xdefaults $TO/.Xdefaults
ln -s $FROM/.ctags $TO/.ctags
ln -s $FROM/.msmtprc $TO/.msmtprc
ln -s $FROM/.mutt $TO/.mutt
ln -s $FROM/.offlineimaprc $TO/.offlineimaprc
ln -s $FROM/.xinitrc $TO/.xinitrc
ln -s $FROM/.Xmodmap $TO/.Xmodmap
ln -s $FROM/.profile $TO/.bash_profile
ln -s $FROM/.profile $TO/.zprofile
ln -s $FROM/.zshrc $TO/.zshrc
ln -s $FROM/gitglobalconfig $TO/.gitconfig
ln -s $FROM/vimrc $TO/.vimrc
ln -s $FROM/s.sh $TO/s.sh
ln -s $FROM/battery_monitor_loop.sh $TO/battery_monitor_loop
ln -s $FROM/i3 $TO/.config/i3
ln -s $FROM/tmux.conf $TO/.tmux.conf

if [ ! -f /etc/X11/xorg.conf.d/70-synaptics.conf ]
then
    sudo cp $FROM/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf
    echo -e ${end}${light_yellow}"Copied synaptics.conf!"${end}
fi

OH_MY_ZSH=$HOME'/.oh-my-zsh'
if [ ! -d $OH_MY_ZSH ]
then

    echo -e ${yellow}"Installing Oh-My-Zsh..."
    git clone https://github.com/robbyrussell/oh-my-zsh.git $OH_MY_ZSH
    echo -e ${end}${light_yellow}"Done!"${end}
fi

#vim bundle
$VIM_BUNDLE=$HOME'/.vim/bundle/Vundle.vim'
if [ ! -d $VIM_BUNDLE]
then

    echo -e ${yellow}"Installing Vundle.vim..."
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git $VIM_BUNDLE
    echo -e ${end}${light_yellow}"Done!"${end}
fi
