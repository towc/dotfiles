https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

pre-dotfiles
```
sudo apt install git
ssh-keygen # and add to github
```

installing dotfiles
```
dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'
git clone --bare git@github.com:towc/dotfiles.git $HOME/.dotfiles-git
dotfiles checkout
```

# kitty terminal
```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which kitty` 50
```

# oh-my-zsh / tmux

```
sudo apt-get install zsh tmux fonts-powerline wmctrl
# hide previous installation from installer
mv -f .oh-my-zsh .oh-my-zsh-tmp
mv .zshrc .zshrc-tmp
# installation script (sets zsh to default shell and the rest of it)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# move back
mv -f .oh-my-zsh-tmp .oh-my-zsh
mv .zshrc-tmp .zshrc
# install custom plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone git@github.com:marzocchi/zsh-notify.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/notify
curl https://raw.githubusercontent.com/towc/dotfiles/master/.oh-my-zsh/themes/agnoster.zsh-theme > .oh-my-zsh/themes/agnoster.zsh-theme
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# node
```
curl -fsSL https://fnm.vercel.app/install | bash
fnm install --lts
npm i -g serve fkill-cli eslint tldr yarn
```

# vim

```
sai neovim silversearcher-ag
v --version # make sure it's above 0.6
mkdir .vim/colors
curl https://raw.githubusercontent.com/danilo-augusto/vim-afterglow/master/colors/afterglow.vim > .vim/colors/afterglow.vim
# run \pi from vim
# for wt api key: https://wakatime.com/settings/account
```


# other packages
```
sai keepassx
flatpak install slack
```

# keybindings
```
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>Home', '<Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['<Super>7']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['<Super>8']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "['<Super>9']"
```

