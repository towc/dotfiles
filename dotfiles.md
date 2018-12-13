https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

pre-dotfiles
```
sudo apt install git
ssh-keygen # and add to github
```

installing dotfiles
```
config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare git@github.com:towc/dotfiles.git $HOME/.cfg
config checkout
```

# oh-my-zsh

```
sudo apt-get install zsh tmux fonts-powerline
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
curl https://raw.githubusercontent.com/towc/dotfiles/master/.oh-my-zsh/themes/agnoster.zsh-theme > .oh-my-zsh/themes/agno ster.zsh-theme
# reboot for changes to happen, or `zsh` for now
```

# vim

```
sai vim
vim --version # make sure it's above 8
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir .vim/colors
curl https://raw.githubusercontent.com/danilo-augusto/vim-afterglow/master/colors/afterglow.vim .vim/colors/afterglow.vim
# run \pi from vim
# for wt api key: https://wakatime.com/settings/account
```

# i3
```
sai i3 i3blocks rofi chromium-browser
```

# alacritty
```
# install from repo, then
sudo update-alternatives --config x-terminal-emulator
```

# other packages
```
sai redshift vlock w3m bvi r2 xbacklight nmap feh
```
