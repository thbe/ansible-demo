# Custom plugin for zsh
#
# Docker functions
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Wed Jan  1 23:54:03 CET 2020
#

### Docker enhancement functions ###
do-upg() {
  docker-machine upgrade default
}
do-c() {
  docker-compose $@
}
do-ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}
do-cl-img() {
  for item in $(docker images | grep "<none>" | sed -e 's/  */ /g' | cut -d ' ' -f3); do
    docker rmi $item
  done
}
