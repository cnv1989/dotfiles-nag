import os
import stat


files = [
    ('bash_profile', '.bash_profile'),
    ('bash', '.bash'),
    ('gitconfig', '.gitconfig'),
    ('git-branch-cleanup', 'git-branch-cleanup'),
    ('inputrc', '.inputrc'),
    ('tmux.conf', '.tmux.conf'),
    ('vimrc', '.vimrc')
]

CMDS = (
    'source ~/.bash_profile',
    'rm -rf ~/.vim',
    'mkdir -p ~/.vim/bundle/',
    'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim',
    'vim +PluginInstall +qall'
)

if __name__ == "__main__":
    # for src, dst in files:
    #     src = os.path.abspath(src)
    #     dst = os.path.join(os.path.expanduser("~"), dst)
    #     os.system('rm -rf ' + dst)
    #     os.symlink(src, dst)

    # for cmd in CMDS:
    #     os.system(cmd)

    local_bin = os.path.abspath('local_bin')
    for root, directories, files in os.walk(local_bin):
        for file in files:
            dst = os.path.join(os.path.expanduser("~"), 'local_bin')
            if not os.path.exists(dst):
                os.mkdir(dst)
            os.system('rm -rf ' + os.path.join(dst, file))
            os.symlink(os.path.join(root, file), os.path.join(dst, file))
            st = os.stat(os.path.join(dst, file))
            os.chmod(os.path.join(dst, file), st.st_mode | stat.S_IEXEC)

    os.system('source ~/.bash_profile')
