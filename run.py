import os


files = [
    ('bash_profile', '.bash_profile'),
    ('bash', '.bash'),
    ('gitconfig', '.gitconfig'),
    ('git-branch-cleanup', 'git-branch-cleanup'),
    ('inputrc', '.inputrc'),
    ('tmux.conf', '.tmux.conf'),
    ('vimrc', '.vimrc'),
]

CMDS = (
    'source ~/.bash_profile',
    'rm -rf ~/.vim',
    'mkdir -p ~/.vim/bundle/',
    'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim',
    'vim +PluginInstall +qall'
)

if __name__ == "__main__":
    for src, dst in files:
        src = os.path.abspath(src)
        dst = os.path.join(os.path.expanduser("~"), dst)
        os.system('rm -rf ' + dst)
        os.symlink(src, dst)

    for cmd in CMDS:
        os.system(cmd)
