# Custom plugin for zsh
#
# Nerd functions
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Wed Jan  1 23:54:03 CET 2020
#

### Nerd section ###
excuse() { echo $(telnet bofh.jeffballard.us 666 2>/dev/null) | grep --color -o "Your excuse is:.*$" ; }
starwars() { telnet towel.blinkenlights.nl ; }
weather() { curl wttr.in/$1 ; }
