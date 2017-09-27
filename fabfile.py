import os
import logging
import platform
from fabric.api import local, task

HOME = os.path.expanduser('~')
DOTFILES = ('.gitconfig', '.bash_profile', '.bash', '.vimrc', '.inputrc', '.tmux.conf')
CMDS = (
    'source ~/.bash_profile',
    'vim +PluginInstall +qall',
    'mkdir -p ~/.vim/bundle/',
    'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim',
    'sudo gem install tmuxinator'
)

MAC_CMDS = (
)

LINUX_CMDS = (
    'sudo apt-get install tig',
    'sudo apt-get install tmuxinator',
    'sudo apt-get install build-essential cmake',
    'sudo apt-get install python-dev python3-dev'
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

    os_info = platform.linux_distribution()

    if os_info[0] == 'Ubuntu':
        for cmd in LINUX_CMDS:
            os.system(cmd)
