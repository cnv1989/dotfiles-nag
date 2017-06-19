import os
import logging
from fabric.api import local, task

HOME = os.path.expanduser('~')
DOTFILES = ('.gitconfig', '.bash_profile', '.bash', '.vimrc', '.inputrc', '.tmux.conf')
CMDS = (
    'mkdir -p ~/.vim/bundle/',
    'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim',
    'sudo apt-get install tig',
    'gem install tmuxinator'
)

@task
def dotfiles():
    logging.info('Installing dotfiles...')
    for dotfile in DOTFILES:
        filepath = '%s/dotfiles-nag/%s' % (HOME, dotfile)
        linkpath = '%s/%s' % (HOME, dotfile)
        cmd_output = local('rm -rf %s' % linkpath, capture=True)
        logging.debug(cmd_output)
        os.symlink(filepath, linkpath)
        logging.info('Installed dotfile %s' % dotfile)

    for cmd in CMDS:
        os.system(cmd)
