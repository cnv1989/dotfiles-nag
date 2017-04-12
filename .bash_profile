# Search History
HISTFILESIZE=1000000000
HISTSIZE=1000000

#export CLICOLOR=1

#export LSCOLORS=GxFxCxDxBxegedabagaced
export MATLAB_EXECUTABLE=/Applications/MATLAB_R2015b.app/bin/matlab
export PYTHONSTARTUP=$HOME/.pystartup
source ~/.bash/git-completion.bash
source ~/.bash/tmux.completion.bash

alias sites="cd ~/Sites/"
alias makers="sites && cd makers"

export FANMGMT="~/projects/HearsayLabs/fanmgmt/"

alias docs="cd ~/Documents/"
alias downloads="cd ~/Downloads/"
alias dropbox="cd ~/Dropbox/"
alias desktop="cd ~/Desktop/"
alias fanmgmt="cd $FANMGMT"
alias poly="~/projects/project-poly"
alias libpoly="~/projects/libpoly"
# SSH aliases
alias hsdev="ssh nchunduru.dev.hearsaylabs.com"
alias hsops="ssh ops.prod.pnw.hearsaylabs.com"

alias mkve3='mkvirtualenv --no-site-packages --python=/usr/local/Cellar/python3/3.4.1/bin/python3.4'
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
    br_len=$(expr ${#git_branch} - 1)
    br_name="$(echo "$git_branch"| cut -c2-$br_len)"
    if [ $br_len -gt 10 ]; then
        br_name="$(echo "$br_name" | cut -c1-10)..."
    fi
    
    echo "($br_name)"
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
alias branch="git fetch upstream && git checkout upstream/master -b"
alias sorted_branches="git for-each-ref --sort=-committerdate refs/heads/"
alias br="git branch | grep -v \* | tr -d ' '"

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

alias fmenv="fanmgmt && ~/projects/HearsayLabs/scripts/build_virtual_env.sh"
alias fmselenium="fanmgmt && ./run.sh manage.py selenium_test --settings=settings.jenkins --remote --browser={ie|firefox|chrome}"
alias fmjasmine="fangmt && ./run.sh run_jasmine.py"
alias fmipnb="fanmgmt && ./run.sh manage.py shell_plus --settings=settings.nchunduru --notebook"

pytest() {
    current_path=$(pwd)
    test_path=$1
    
    project=$(echo $1| cut -d'.' -f 1)

    if [ -z $1 ]; then
        $project="fanmgmt"
    fi

    if [ "$project" == "poly" ]; then
        settings="poly.settings.test"
    elif [ "$project" == "fanmgmt" ]; then
        settings="settings.nchunduru"
    fi

    eval $project && .virtualenv/bin/python manage.py test --settings=$settings $test_path
    eval "cd $current_path"
}

shell() {
    current_path=$(pwd)
    project=$1
    org_id=$2
    
    if [ -z $1 ]; then
        project="fanmgmt"
    fi
    
    if [ -z $2 ]; then
        org_id=1
    fi

    if [ "$project" == "poly" ]; then
        settings="poly.settings.dev"
    elif [ "$project" == "fanmgmt" ]; then
        settings="settings.nchunduru"
    fi
    eval $project && .virtualenv/bin/python manage.py shell --organization=$org_id --settings=$settings
    eval "cd $current_path"
}

celery() {
    current_path=$(pwd)
    project=$1
    if [ -z $1 ]; then
        project="fanmgmt"
    fi
	eval $project && make celery
    eval "cd $current_path"
}

shell_plus() {
    current_path=$(pwd)
	poly && .virtualenv/bin/python manage.py shell_plus --settings=poly.settings.dev --notebook
    eval "cd $current_path"
}

alias poly_test="poly && .virtualenv/bin/python manage.py test --settings=poly.settings.test"
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

# remote git aliases
alias hs-labs="ssh nchunduru.dev.hearsaylabs.com \"cd ~/projects/HearsayLabs && $*\""
alias hs-test="ssh nchunduru.dev.hearsaylabs.com \"echo -e 'Changing Directory to $FANMGMT' && cd $FANMGMT && ~/projects/HearsayLabs/fanmgmt/run.sh manage.py test --settings=settings.nchunduru\""
alias git-ssh="ssh nchunduru.dev.hearsaylabs.com \"cd ~/projects/HearsayLabs && git\""
alias git-remote-diff="diff <(git diff upstream/master) <(git-ssh diff upstream/master)"
alias grdiff="git-remote-diff"

git-local-ssh() {
    a=$*
    echo "==========HS-LABS REMOTE============"
    git-ssh $a
    echo "===============LOCAL================"
    git $a
    echo "===================================="
}

git-local-ssh-co() {
    a=$1
    echo "==========HS-LABS REMOTE============"
    git-ssh checkout -b remote_dev_$a
    echo "===============LOCAL================"
    git fetch upstream
    git checkout -b local_$a
    echo "===================================="
}

git-local-ssh-new-branch() {
    a=$1
    echo "==========HS-LABS REMOTE============"
    git-ssh fetch upstream
    git-ssh checkout upstream/master -b remote_$a
    echo "===============LOCAL================"
    git fetch upstream
    git checkout upstream/master -b local_$a
    echo "===================================="
}

alias gls="git-local-ssh"
alias glsb="git-local-ssh-new-branch"
alias glsco="git-local-ssh-co"

git-clean() {
    for b in `git branch | grep -v \*`; do git branch -D $b; done
}

git-clr() {
    git clean -fd && git reset --hard
}

checkout() {
    branch_name=$1
    if [ -z "$1" ]; then
        branch_name=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    fi
    git checkout -b temp_branch_during_checkout
    git branch -D $branch_name
    git fetch origin
    git checkout origin/$branch_name -b $branch_name
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

notebook() {
    browser=$1
    if [ -z "$1" ]; then
        browser="Opera"
    fi
    port=8888
    while lsof -Pi :$port -sTCP:LISTEN -t >/dev/null; do
        port=$(($port + 1))
    done
    $(jupyter notebook --port $port --no-browser) | $(sleep 2s && open -a $browser http://localhost:$port?token=abc)
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

# virtualenv
export WORKON_HOME=~/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
