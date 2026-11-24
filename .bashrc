#git branch in prompt.
source ~/.git-completion.bash
source ~/.git-prompt.sh

MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
UNDBLUE="\[\033[4;94m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
COLORRESET="\[\033[0;0m\]"
GIT_PS1_SHOWDIRTYSTATE=true
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

export PS1=$LIGHT_GRAY"$UNDBLUE\w"'$(if [[ $(__git_ps1) =~ \*\)$ ]]; then echo "'$YELLOW'"$(__git_ps1 " (%s)"); elif [[ $(__git_ps1) =~ \+\)$ ]]; then echo "'$MAGENTA'"$(__git_ps1 " (%s)"); else echo "'$CYAN'"$(__git_ps1 " (%s)"); fi)'" "$COLORRESET": "

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="ls -lG"
alias ll="ls -alh"
alias pp="git pull && git remote prune origin"
alias serverlist="cat ~/.ssh/config"
alias main="git checkout master || git checkout main"
alias updatechrome="npm install -g chromedriver --chromedriver-force-download"
alias g=navigateToProjectHome
alias when=gitbranchdate

export NVM_DIR="/Users/sking/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

function navigateToProjectHome() {
  cd ~/Projects
  case "$1" in
  m)
    cd project1
    ;;
  *)
    cd .
    ;;
  esac
}

function gitbranchdate() {
  for k in $(git branch | sed s/^..//); do echo -e $(git log --color=always -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k --)\\t"$k";done | sort
}
