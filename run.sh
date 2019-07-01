#!/usr/bin/env bash

DOTFILES=('bashrc' 'bash' 'gitconfig' 'inputrc' 'tmux.conf' 'vimrc')

for dotfile in ${DOTFILES[@]}; do
    if [[ -e ${HOME}/.${dotfile} ]]; then
        echo "Remove the symlink ${HOME}/.${dotfile}"
        rm ${HOME}/.${dotfile}
    fi
    echo "Create symlink ${HOME}/.${dotfile}"
    ln -s ${PWD}/${dotfile} ${HOME}/.${dotfile}
done


if [[ -e ${HOME}/.bash_profile ]]; then
    echo "Remove the symlink ${HOME}/.bash_profile"
    rm ${HOME}/.bash_profile
fi

touch ${HOME}/.bash_profile
cat > ${HOME}/.bash_profile << EOM
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
EOM
