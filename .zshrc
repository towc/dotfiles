export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

export WORK=/home/user/work/toptal/deepchannel

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
PATHS=""
PATHS+="./bin"
PATHS+=":$WORK/bin"
PATHS+=":./node_modules/.bin"
PATHS+=":$HOME/.npm-global/bin"
PATHS+=":$HOME/.bin"
PATHS+=":$HOME/.deno/bin"
PATHS+=":$HOME/.cargo/bin"
PATHS+=":$HOME/.local/bin"
PATHS+=":/snap/bin"
PATHS+=":$HOME/bin"
PATHS+=":$HOME/.fzf/bin"
PATHS+=":$HOME/.gem/ruby/2.3.0/bin"
PATHS+=":$HOME/.gem/bin"
PATHS+=":$HOME/go/bin"
PATHS+=":/home/nvidia/.local/bin"
PATHS+=":/opt/wine-stable/bin"
PATHS+=":$JAVA_HOME/bin"
PATHS+=":$HOME/.local/kitty.app/bin"

export PATH=$PATHS:$PATH

export N_PREFIX=$HOME
export ANDROID_SDK=$HOME/Android/Sdk

if type rustc > /dev/null; then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# syntax highlighting with bat
export BAT_THEME='Visual Studio Dark+'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

stty stop undef
stty start undef
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
DEFAULT_USER="user"
prompt_context(){}

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

if [[ ! -o login ]]; then
  if [[ ! -v ZSH_TMUX_AUTOSTART ]]; then
    ZSH_TMUX_AUTOSTART=true
  fi
  ZSH_TMUX_AUTOQUIT=true
fi
ZSH_TMUX_AUTOCONNECT=false
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  node
  deno
  npm
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
  dirhistory
  wd
  ssh-agent
  notify
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# unbind c-s and c-q
stty stop ''
stty start ''
stty -ixon
stty -ixoff

exec-exit () exit

zle -N exec-exit
bindkey ^q exec-exit

alias galias="alias | grep "

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'
alias q='exit'
alias greps='ps aux | grep'
pids() { greps $1 | grep -v grep | sed -re 's/^[^0-9]+//' | sed -re 's/ .+//' }
agg() { git grep $1 $(git rev-list all) }
alias gbb='git symbolic-ref --short HEAD'
alias gpc='git push origin $(git_current_branch)'

alias sau='sudo apt-get update'
alias sadu='sudo apt-get dist-upgrade'
alias sai='sudo apt-get install'
alias sap='sudo apt-get purge'
alias acs='apt-cache search'
alias sdi='sudo dpkg -i'
alias dl='dpkg -l'
alias sdl='dl'

alias dc='docker-compose'
alias sdc='sudo docker-compose'
alias dcu='docker-compose up'

alias ni='npm install --save'
alias nd='npm uninstall --save'
alias nig='npm install --save -g'
alias ndg='npm uninstall --save -g'
alias pi='pip install --user'
alias ei='elm install'

alias py='python3'
alias v='nvim'
alias vz='v ~/.zshrc'
alias sz='source ~/.zshrc'
alias src='source ~/.zshrc && tmux source ~/.tmux.conf'
alias vsrc='v ~/.zshrc ~/.tmux.conf ~/.vimrc'

alias copy='xclip -sel clip'
alias myip4='dig myip.opendns.com @resolver1.opendns.com +short'
alias myip='ip -6 addr | grep "3: " -A1 | grep inet | cut -d" " -f6 | cut -d/ -f1'
alias L='less -R'

alias kdiff='kitty +kitten diff'
alias dict='cat /usr/share/dict/words'
alias words=dict

#alias -g H='| head'
#alias -g T='| tail'
#alias -g G='| grep'
#alias -g L="| less"
#alias -g M="| most"

alias ssp='kill -STOP'
sspn() { ssp $(pids $1)}
alias cnt='kill -CONT'
cntn() { cnt $(pids $1)}
killn() { kill $(pids $1)}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# remove bell
set bell-style none

# fnm
export PATH=/home/user/.fnm:$PATH
eval "`fnm env`"

# OPAM configuration
. /home/user/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# stripe completion
fpath=(~/.stripe $fpath)

# kitty completions
kitty + complete setup zsh | source /dev/stdin

# trigger completions
autoload -Uz compinit
compinit -i

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/user/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/user/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/user/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/user/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export METAVOICECODE_ROOT=/home/user/work/metavoice/git/github/MetaVoiceCode
export PYTHONPATH=/home/user/work/metavoice/git/github/MetaVoiceCode:$PYTHONPATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/user/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/user/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/user/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/user/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export METAVOICECODE_ROOT=/home/user/work/metavoice/git/github/MetaVoiceCode
export PYTHONPATH=/home/user/work/metavoice/git/github/MetaVoiceCode:$PYTHONPATH
export METAVOICECODE_ROOT=/home/user/work/metavoice/git/github/MetaVoiceCode
export PYTHONPATH=/home/user/work/metavoice/git/github/MetaVoiceCode:$PYTHONPATH
