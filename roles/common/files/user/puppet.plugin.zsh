# Custom plugin for zsh
#
# Puppet functions
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Wed Jan  1 23:54:03 CET 2020
#

### Puppet development functions ###
rev_puppet_module_upgrade() {
  for item in $(ls -1d ./* | grep -E "/$"); do
    CUR_DIR=$(pwd)
    cd $item
    test -e metadata.json && echo Upgrade Puppet module in $item
    test -e metadata.json && puppet module upgrade --modulepath $CUR_DIR $(grep name metadata.json | head -1 | cut -d '"' -f4)
    cd ..
  done
}
rev_puppet_build() {
  for item in $(ls -1d ./* | grep -E "/$"); do
    cd $item
    echo Build Puppet module in $item
    test -e metadata.json && puppet module build
    cd ..
  done
}
puppet_test() {
  bundle exec rake validate
  bundle exec rake lint
  bundle exec rake spec
}
puppet_validate() {
  bundle exec rake validate
  bundle exec rake lint
  COVERALLS_RUN_LOCALLY=true; bundle exec rake spec
}
rev_bundle_update() {
  for item in $(ls -1d ./* | grep -E "/$"); do
    cd $item
    echo Updating repository $item
    test -e Gemfile && bundle update
    cd ..
  done
}
validate_erb() {
  erb -P -x -T '-' ${1} | ruby -c
}
