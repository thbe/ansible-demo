# zsh configuration file
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Thu Jan  2 17:53:48 GMT 2020

# Add local sbin to $PATH.
export PATH="/usr/local/sbin:${PATH}"

# Path to the oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Define how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Configure history stamp format
HIST_STAMPS="yyyy-mm-dd"

# Plugin configuration
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  ansible
  bundler
  colored-man-pages
  colorize
  common-aliases
  debian
  git
  nmap
  zsh-navigation-tools
  zsh_reload
)

ZSH_THEME="typewritten/typewritten"

# Load zsh extensions
[ -e /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load oh-my-zsh framework
[ -e ${HOME}/.oh-my-zsh/oh-my-zsh.sh ] && source ${HOME}/.oh-my-zsh/oh-my-zsh.sh
