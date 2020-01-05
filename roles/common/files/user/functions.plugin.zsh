# Custom plugin for zsh
#
# Common functions
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Wed Jan  1 23:54:03 CET 2020
#

### Command enhancement functions ###
.1() { cd ../ ; }                                  # Go back 1 directory level
.2() { cd ../../ ; }                               # Go back 2 directory levels
.3() { cd ../../../ ; }                            # Go back 3 directory levels
.4() { cd ../../../../ ; }                         # Go back 4 directory levels
.5() { cd ../../../../../ ; }                      # Go back 5 directory levels
.6() { cd ../../../../../../ ; }                   # Go back 6 directory levels
root() { sudo su - ; }                             # root:         Switch to root user using sudo
f() { open -a Finder ./ ; }                        # f:            Opens current directory in MacOS Finder
c() { clear ; }                                    # c:            Clear terminal display
path() { echo -e ${PATH//:/\\n} ; }                # path:         Echo all executable Paths
show_options() { shopt ; }                         # Show_options: display bash options settings
fix_stty() { stty sane ; }                         # fix_stty:     Restore terminal settings when screwed up
mount() { sudo mount | column -t ; }               # mount:        Human readable mount
fastping() { \ping -c 100 -s 1 "$@" ; }            # fastping:     Send 100 one byte packages plus header
j() { jobs -l ; }                                  # j:            List jobs
hibernate() { sudo pmset -a hibernatemode 25 ; }   # hibernate:    Set hibernate mode
sleep() { sudo pmset -a hibernatemode 0 ; }        # sleep:        Set sleep mode
safesleep() { sudo pmset -a hibernatemode 3 ; }    # safesleep:    Set safe sleep mode
smartsleep() { sudo pmset -a hibernatemode 2 ; }   # smartsleep:   Set smart sleep mode
cowdate() { LANG=C date | cowsay ; }               # cowdate:      Show date announced by cow

### Tools ###
rbrew_upgrade() {
  brew update && brew upgrade
}
rbrew_doctor() {
  brew update && brew upgrade && brew cleanup; brew doctor
}

### Functions (network) ###
myip() { curl ip.appspot.com ; }                   # myip:         Public facing IP Address
netCons() { lsof -i ; }                            # netCons:      Show all open TCP/IP sockets
flushDNS() { dscacheutil -flushcache ; }           # flushDNS:     Flush out the DNS Cache
lsock() { sudo /usr/sbin/lsof -i -P ; }            # lsock:        Display open sockets
lsockU() { sudo /usr/sbin/lsof -nP | grep UDP ; }  # lsockU:       Display only open UDP sockets
lsockT() { sudo /usr/sbin/lsof -nP | grep TCP ; }  # lsockT:       Display only open TCP sockets
ipInfo0() { ipconfig getpacket en0 ; }             # ipInfo0:      Get info on connections for en0
ipInfo1() { ipconfig getpacket en1 ; }             # ipInfo1:      Get info on connections for en1
openPorts() { sudo lsof -i | grep LISTEN ; }       # openPorts:    All listening connections
showBlocked() { sudo ipfw list ; }                 # showBlocked:  All ipfw rules inc/ blocked IPs
httpHeaders() { /usr/bin/curl -I -L $@ ; }         # httpHeaders:  Grabs headers from web page
httpDebug() { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }
ipLocal() {
  for i in $(ifconfig -l); do
    case $i in
      (lo0) ;;
      (*)   set -- $(ifconfig $i | grep "inet [1-9]")
            if test $# -gt 1; then echo $i: $2; fi  ;;
    esac
  done
}

### Functions (system) ###
mountReadWrite() { /sbin/mount -uw / ; }
findPid() { lsof -t -c "$@" ; }
memHogsTop() { top -l 1 -o rsize | head -20 ; }
memHogsPs() { ps wwaxm -o pid,stat,vsize,rss,time,command | head -10 ; }
topForever() { top -l 9999999 -s 10 -o cpu ; }
ttop() { top -R -F -s 10 -o rsize ; }
cpu_hogs() { ps wwaxr -o pid,stat,%cpu,time,command | head -10 ; }
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }
ii() {
  echo -e "\nYou are logged on ${HOSTNAME}"
  echo -e "\nAdditionnal information:   " ; uname -a
  echo -e "\nUsers logged on:           " ; w -h
  echo -e "\nCurrent date:              " ; date
  echo -e "\nMachine stats:             " ; uptime
  echo -e "\nPublic facing IP Address:  " ; myip
  echo
}

### Functions (filemanagement) ###
finderShowHidden() { defaults write com.apple.finder ShowAllFiles TRUE ; }
finderHideHidden() { defaults write com.apple.finder ShowAllFiles FALSE ; }
dush() { du -sm * | sort -n | tail ; }
numFiles() { echo $(ls -1 | wc -l) ; }             # numFiles:     Count of non-hidden files in current dir
cleanupDS() { find . -type f -name '*.DS_Store' -ls -delete ; }
mcd() { mkdir -p "$1" && cd "$1" ; }               # mcd:          Makes new Dir and jumps inside
ql() { qlmanage -p "$*" >& /dev/null ; }           # ql:           Opens any file in MacOS Quicklook Preview
zipf() { zip -r "$1".zip "$1" ; }                  # zipf:         To create a ZIP archive of a folder
trash() { command mv "$@" ~/.Trash ; }             # trash:        Moves a file to the MacOS trash
spotlight() { mdfind "kMDItemDisplayName == '$@'wc" ; }
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1       ;;
      *.tar.gz)    tar xvzf $1       ;;
      *.bz2)       bunzip2 -v $1     ;;
      *.rar)       unrar x $1        ;;
      *.gz)        gunzip -v $1      ;;
      *.tar)       tar xvf $1        ;;
      *.tbz2)      tar xvjf $1       ;;
      *.tgz)       tar xvzf $1       ;;
      *.zip)       unzip -v $1       ;;
      *.Z)         uncompress -v $1  ;;
      *.7z)        7z x $1           ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
makefile_1mb() { mkfile 1m ./1MB.dat ; }           # makefile_1mb:      Creates a file of 1mb size (all zeros)
makefile_5mb() { mkfile 5m ./5MB.dat ; }           # makefile_5mb:      Creates a file of 5mb size (all zeros)
makefile_10mb() { mkfile 10m ./10MB.dat ; }        # makefile_10mb:     Creates a file of 10mb size (all zeros)
