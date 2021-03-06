#!/usr/bin/env bash

DOTFILES=('bash' 'gitconfig' 'inputrc' 'tmux.conf' 'vimrc')

for dotfile in ${DOTFILES[@]}; do
    if [[ -e ${HOME}/.${dotfile} ]]; then
        echo "Remove the symlink ${HOME}/.${dotfile}"
        rm ${HOME}/.${dotfile}
    fi
    echo "Create symlink ${HOME}/.${dotfile}"
    ln -s ${PWD}/${dotfile} ${HOME}/.${dotfile}
done
