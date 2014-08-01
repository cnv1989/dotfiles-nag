# Search History
HISTFILESIZE=1000000000
HISTSIZE=1000000

export CLICOLOR=1

export LSCOLORS=GxFxCxDxBxegedabagaced

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh
source ~/.bash/git-completion.bash

alias sites="cd ~/Sites/"
alias makers="sites && cd makers"

export FANMGMT="~/projects/HearsayLabs/fanmgmt/"

alias docs="cd ~/Documents/"
alias downloads="cd ~/Downloads/"
alias dropbox="cd ~/Dropbox/"
alias desktop="cd ~/Desktop/"
alias fanmgmt="cd $FANMGMT"

# SSH aliases
alias hsdev="ssh nchunduru.dev.hearsaylabs.com"
alias hsops="ssh ops.prod.pnw.hearsaylabs.com"

alias mkve3='mkvirtualenv --no-site-packages --python=/usr/local/Cellar/python3/3.4.1/bin/python3.4'
alias tmux="TERM=screen-256color-bce tmux"

if [ "$PS1" ]; then
	complete -cf sudo
fi

# Cool CD alias
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# LS Alias
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lx='ls -lXB' # Sort by extension
alias lk='ls -lSr' # Sort by size (small to big)
alias lc='ls -ltcr' # Sort by change time (old to new)
alias lu='ls -ltur' # Sort by change time (new to old)
alias lt='ls -ltr' # Sort by date (old to new)

# Hadoop stuff
# export HADOOP_INSTALL=/Users/nchunduru/Documents/Apps/hadoop-1.2.1
# export PATH=$PATH:$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin

# Git branch in prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\h|\W\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]:\u\$ "

# Git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gtfo="git push origin head --force"
alias rtfb="git fetch upstream && git rebase upstream/master"
#mysql
export PATH=$PATH:~/local_bin

#make
alias remake='make clean; make'
alias mkrun='make clean; make; make run'

# ———————————————–
# General
# ———————————————–

alias c='clear' # Clear the screen
alias df='df -Th' # Disk free space
alias du='du -h' # Disk usage
alias h='history' # Bash history
alias j='jobs -l' # Current running jobs

shopt -s autocd
shopt -s cdspell
shopt -s dirspell

alias djtest="./run.sh manage.py test"