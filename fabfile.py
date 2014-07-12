import os
import logging
from fabric.api import local, task


HOME = os.path.expanderuser(~)
DOTFILES = (
	'.gitconfig',
	'.bashrc',
	'.bash_profile',
	'.bash',
	'.vimrc',
	'.vim',
	)


def create_dir(target_path):
	if os.path.exists(target_path) and not os.path.isdir(target_path):
		os.remove(target_path)
		logging.info('Removed %s' % target_path)
	
	if not os.path.exists(target_path):
		os.mkdir(target_path)
		logging.info('Created %s' % target_path)

@task
def dotfiles():
	logging.info('Installing dotfiles...')
	for dotfile in DOTFILES:
		filtpath = '%s/dotfiles/%s' % (HOME, dotfile)
		linkpath = '%s/%s' % (HOME, dotfile)
		cmd_output = local('rm -rf %s' % linkpath, capture=True)
		logging.debug(cmd_output)
		os.symlink(filepath, linkpath)
		logging.info('Installed dotfile %s' % dotfile)
