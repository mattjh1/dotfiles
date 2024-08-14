#!/usr/bin/env bash

set -euoE pipefail

# shellcheck disable=SC2086
cwd="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"

os=""

detect_os() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    os=$ID
  else
    echo "Unsupported OS"
    exit 1
  fi
}

install_debian_packages() {
  apt="sudo apt -y"
  $apt update

  sudo add-apt-repository --yes --update ppa:ansible/ansible

  install_from_package_list() {
    export DEBIAN_FRONTEND=noninteractive
    packages="$(awk '! /^ *(#|$)/' "$1")"
    xargs -a <(echo "$packages") -r -- echo "⚪ [apt] installing packages:"
    xargs -a <(echo "$packages") -r -- $apt --no-install-recommends install
  }

  install_from_package_list "${cwd}/essentials.apt"
}

install_rhel_packages() {
  yum="sudo yum -y"

  sudo $yum install epel-release
  sudo $yum update

  sudo yum-config-manager --enable epel
  sudo yum install -y yum-utils

  install_from_package_list() {
    packages="$(awk '! /^ *(#|$)/' "$1")"
    xargs -a <(echo "$packages") -r -- echo "⚪ [yum] installing packages:"
    xargs -a <(echo "$packages") -r -- $yum install
  }

  install_from_package_list "${cwd}/essentials.yum"
}

main() {
  detect_os
  if [[ $os == "ubuntu" || $os == "debian" ]]; then
    install_debian_packages
  elif [[ $os == "rhel" || $os == "centos" || $os == "fedora" ]]; then
    install_rhel_packages
  else
    echo "Unsupported OS: $os"
    exit 1
  fi
}

main

# #!/usr/bin/env bash
# set -euoE pipefail
#
# # shellcheck disable=SC2086
# cwd="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
#
# os=""
#
# apt="sudo apt -y"
# $apt update
#
# sudo add-apt-repository --yes --update ppa:ansible/ansible
#
# install_from_package_list() {
#   export DEBIAN_FRONTEND=noninteractive
#   packages="$(awk '! /^ *(#|$)/' "$1")"
#   xargs -a <(echo "$packages") -r -- echo "⚪ [apt] installing packages:"
#   xargs -a <(echo "$packages") -r -- $apt --no-install-recommends install
# }
#
# install_from_package_list "${cwd}/essentials.apt"
#
