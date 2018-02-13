# Search History
HISTFILESIZE=1000000000
HISTSIZE=1000000

#export CLICOLOR=1

#export LSCOLORS=GxFxCxDxBxegedabagaced
export MATLAB_EXECUTABLE=/Applications/MATLAB_R2015b.app/bin/matlab
export PYTHONSTARTUP=$HOME/.pystartup
source ~/.bash/git-completion.bash
source ~/.bash/tmux.completion.bash

alias docs="cd ~/Documents/"
alias downloads="cd ~/Downloads/"
alias dropbox="cd ~/Dropbox/"
alias desktop="cd ~/Desktop/"

alias tmux="TERM=screen-256color-bce tmux"

if [ "$PS1" ]; then
	complete -cf sudo
fi

function mkdircd () { 
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

# Cool CD alias
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias up="cd .."
alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."

# LS Alias
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	alias ls='ls --color=always'
fi
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lx='ls -lXB' # Sort by extension
alias lk='ls -lSr' # Sort by size (small to big)
alias lc='ls -ltcr' # Sort by change time (old to new)
alias lu='ls -ltur' # Sort by change time (new to old)
alias lt='ls -ltr' # Sort by date (old to new)
alias ldf='ls -d -1 $PWD/**' # list directory with fullpath
alias lf='ls -d -1 $PWD/*.*' # list files with fullpath.	

# Hadoop stuff
# export HADOOP_INSTALL=/Users/nchunduru/Documents/Apps/hadoop-1.2.1
# export PATH=$PATH:$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin

# Git branch in prompt
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}\007"'
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh

function git_prompt_branch() {
    if [ ${#git_branch} -gt 10 ]; then
        br_len=$(expr ${#git_branch} - 1)
        br_name="$(echo "$git_branch"| cut -c2-$br_len)"
        if [ $br_len -gt 10 ]; then
            br_name="$(echo "$br_name" | cut -c1-10)..."
        fi
        echo "($br_name)"
    else
        echo "$git_branch"
    fi
}


export PS1="\W\[$txtcyn\]\$(git_prompt_branch)\[$txtred\]\$git_dirty\[$txtrst\]\$ "



# Git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gtfo="git push origin HEAD --force"
alias rtfb="git fetch upstream && git rebase upstream/master"
alias gdfs="git diff upstream/master --name-only"
alias gdu="git diff upstream/master"
alias sorted_branches="git for-each-ref --sort=-committerdate refs/heads/"
alias br="git branch | grep -v \* | tr -d ' '"
alias curr_br="git branch | grep '*' | cut -c 3-"

branches() {
    number_of_branches=$1

    if [ -z $1 ]; then
        number_of_branches=5
    fi
    IFS=$'\n'

    for br in $(sorted_branches | head -n $number_of_branches)
    do
        commit=$(echo $br | cut -d' ' -f 1)
        branch=$(echo $br | cut -d'/' -f 3)
        printf '%s\t%s\n' "$commit $branch"
    done
}

delete() {
    branch_name=$1
    echo "Deleting $branch from Remote"
    eval "git push origin --delete $branch_name"
    echo "Deleting $branch from Local"
    eval "git branch -D $branch_name"
}

#mysql
export PATH=$PATH:~/local_bin

#make
alias remake='make clean; make'
alias mkrun='make clean; make; make run'

# General
alias c='clear' # Clear the screen
alias df='df -Th' # Disk free space
alias du='du -h' # Disk usage
alias h='history' # Bash history
alias j='jobs -l' # Current running jobs

if [[ "$OSTYPE" == "linux-gnu" ]]; then
       shopt -s autocd
       shopt -s cdspell
       shopt -s dirspell
elif [[ "$OSTYPE" == "darwin"* ]]; then
       shopt -s cdspell
fi

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
	if [[ "$OSTYPE" == "darwin"* ]]; then
		local _scs_col="\x1B[0;32m"; local _wrn_col='\x1B[1;31m'; local _trn_col='\x1B[0;33m'; _end_col='\x1B[0m'
	else
		local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'; _end_col='\e[0m'
	fi
  	# Check that xclip is installed.
  	if ! type xclip > /dev/null 2>&1; then
    		echo -e "$_wrn_col You must have the 'xclip' program installed.$_end_col"
  	# Check user is not root (root doesn't have access to user xorg server)
  	elif [[ "$USER" == "root" ]]; then
    		echo -e "$_wrn_col Must be regular user (not root) to copy a file to the clipboard.$_end_col"
  	else
    	# If no tty, data should be available on stdin
    		if ! [[ "$( tty )" == /dev/* ]]; then
      			input="$(< /dev/stdin)"
    		# Else, fetch input from params
    		else
      			input="$*"
    		fi
    		if [ -z "$input" ]; then  # If no input, print usage message.
      			echo "Copies a string to the clipboard."
      			echo "Usage: cb <string>"
      			echo "       echo <string> | cb"
    		else
      			# Copy input to clipboard
      			echo -n "$input" | xclip -selection c
      			# Truncate text for status
      			if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...$_end_col"; fi
      			# Print status.
      			echo -e "$_scs_col""Copied to clipboard:$_end_col $input"
    		fi
 	fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }
# Copy SSH public key
alias cbssh="cbf ~/.ssh/id_rsa.pub"
# Copy current working directory
alias cbwd="pwd | cb"
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb"
# Configuration for ~/.bash_profile, ~/.zshrc etc:
# Pipe anything into `clip` to forward it to Clipper
alias clip="nc localhost 8377"

# tmux 
alias t='tmux'
alias wrst='sudo service uwsgi restart'

git-clean() {
    for b in `git branch | grep -v \*`; do git branch -D $b; done
}

git-clr() {
    git clean -fd && git reset --hard
}

checkout() {
    git-clr
    branch_name=$1
    remote=$2
    if [ -z "$1" ]; then
        branch_name=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    fi

    if [ -z "$2" ]; then
        remote="origin"
    fi
    git checkout -b temp_branch_during_checkout
    git branch -D $branch_name
    git fetch $remote
    git checkout $remote/$branch_name -b $branch_name
    git branch -D temp_branch_during_checkout
}

clean-rebase() {
    git clean -fd && git reset --hard
    rebase origin $1
}

rebase() {
    branch_name=$2
    if [ -z "$2" ]; then
        branch_name=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    fi
    git fetch $1 && git rebase $1/$branch_name
}

branch() {
    branch_name=$1
    new_branch_name=$2
    if [ -z "$1" ]; then
        branch_name=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    fi

    if [ -z "$2" ]; then
        new_branch_name=$branch_name
    fi
    git fetch upstream && git checkout upstream/$branch_name -b $new_branch_name
}

notebook() {
    browser=$1
    if [ -z "$1" ]; then
        browser="Opera"
    fi
    port=8888
    while lsof -Pi :$port -sTCP:LISTEN -t >/dev/null; do
        port=$(($port + 1))
    done
    $(jupyter notebook --port $port --no-browser)
}

ctail() {
    COLORS=("\e[49m" "\e[40m" "\e[41m" "\e[42m" "\e[43m" "\e[44m" "\e[45m" "\e[46m" "\e[47m" "\e[100m" "\e[101m" "\e[102m" "\e[103m" "\e[104m" "\e[105m" "\e[106m" "\e[107m")
    AWK_CMD=''
    for (( i=3; i<=$#; i++))
    do
        CURR_AWK="/${!i}/ {print \"${COLORS[$i]}\" \$0 \"${COLORS[$i]}\"}"
        AWK_CMD="$AWK_CMD $CURR_AWK"
    done
    tail -f $2 | awk '$AWK_CMD'
}

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by Anaconda3 4.3.1 installer
export PATH="/Users/nchunduru/anaconda/bin:$PATH"


# tmuxinator
export EDITOR=vim

tailf-with-colors () {
    if [ -z "$1" ] ; then
        echo "Please specify a file for monitoring"
        return
    fi

    string=$2

    if [ -z "$2" ] ; then
        string=""
    fi

    tail -f $1 | awk '
                IGNORECASE=1;
                {matched=0}
                /INFO/          {matched=1; print "\033[0;37m" $0 "\033[0m"}   # WHITE
                /NOTICE/        {matched=1; print "\033[0;36m" $0 "\033[0m"}   # CYAN
                /WARNING/       {matched=1; print "\033[0;34m" $0 "\033[0m"}   # BLUE
                /ERROR|EXCEPTION/         {matched=1; print "\033[0;31m" $0 "\033[0m"}   # RED
                /ALERT/         {matched=1; print "\033[0;35m" $0 "\033[0m"}   # PURPLE
                matched==0            {print "\033[0;33m" $0 "\033[0m"}   # YELLOW
        '
}

# iTerm
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


# Amazon
alias dev="ssh varunnag.aka.corp.amazon.com"
alias work="cd /workplace/varunnag"


export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short

for f in SDETools envImprovement AmazonAwsCli OdinTools; do
    if [[ -d /apollo/env/$f ]]; then
        export PATH=$PATH:/apollo/env/$f/bin
    fi
done

alias e=emacs
alias bb=brazil-build

alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use --gitMode -p'
alias bwscreate='bws create -n'
alias brc=brazil-recursive-cmd
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbra='bbr apollo-pkg'

# mkvirtualenv
export VENV_DIRECTORY="$HOME/.virtualenvs"

mkvenv () {
    if [ -z "$1" ]; then
        virtualenv -h
        return
    fi

    directory=$VENV_DIRECTORY/$1

    if [ -d $directory ]; then
        echo "virtualenv with the same name already exists"
        return
    fi

    virtualenv $directory
    source $directory/bin/activate 
}

mkvenv3 () {
    if [ -z "$1" ]; then
        virtualenv -h
        return
    fi

    directory=$VENV_DIRECTORY/$1

    if [ -d $directory ]; then
        echo "virtualenv with the same name already exists"
        return
    fi

    virtualenv -p python3 $directory
    source $directory/bin/activate 
}

workon () {
    if [ -x "$1" ]; then
        echo "Provide name of the environment"
        return
    fi
    
    directory=$VENV_DIRECTORY/$1

    if [ ! -d $directory ]; then
        echo "virtualenv doesn't exists"
        return
    fi

    source $directory/bin/activate 
}
#
PATH="$HOME/.node/bin:$PATH"
NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"
MANPATH="$HOME/.node/share/man:$MANPATH"
