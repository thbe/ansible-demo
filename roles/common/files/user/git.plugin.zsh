# Custom plugin for zsh
#
# Git functions
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Wed Jan  1 23:54:03 CET 2020
#

### GIT development functions ###
rev_git_config() {
  for item in $(find . -type d | grep -E "\/\.git$" | sed -e "s/\/\.git$//"); do
    CUR_DIR=$(pwd)
    cd $item
    echo "Repository: $item"
    git config --local -l
    cd $CUR_DIR
  done
}
rev_git_status() {
  clustergit --recursive
}
rev_git_cloc() {
  for item in $(find . -type d | grep -E "\/\.git$" | sed -e "s/\/\.git$//"); do
    CUR_DIR=$(pwd)
    cd $item
    echo "Repository: $item"
    cloc --vcs=git .
    cd $CUR_DIR
  done
}
rev_git_pull() {
  clustergit --recursive --pull
}
rev_git_push() {
  clustergit --recursive --push
}
