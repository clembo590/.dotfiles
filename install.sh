#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

. scripts/utils.sh
. scripts/brew.sh
. scripts/config.sh
. scripts/cli.sh
. scripts/osx.sh
. scripts/fonts.sh
. scripts/stow.sh
. scripts/packages.sh
. scripts/oh-my-zsh.sh

cleanup() {
  echo "Finishing..."
}

wait_input() {
  # read -p "Press enter to continue: "
  echo "Press enter to continue: "
}

trap cleanup EXIT

trap "exit" INT TERM; trap "kill 0" EXIT; sudo -v || exit $?; sleep 1; while true; do sleep 60; sudo -nv; done 2>/dev/null &

main() {
  info "Installing ..."

  info "======= Homebrew packages ======="
  wait_input
  install_packages
  success "Finished installing Homebrew packages"

  info "======= Homebrew Fonts ======="
  wait_input
  install_fonts
  success "Finished installing fonts"

  info "======= Oh-my-zsh ======="
  wait_input
  install_oh_my_zsh
  success "Finished installing Oh-my-zsh"

  install_zsh_plugins
  success "Finished installing Oh-my-zsh plugins"

  info "======= MacOS Apps ======="
  wait_input
#  install_macos_apps

  # install_masApps
  info "skipping macos apps"
  success "Finished installing macOS apps"

  info "======= PiP modules ======="
  wait_input
  install_python_packages
  success "Finished installing python packages"

  info "======= Configuration ======="
  wait_input
  setup_osx
  success "Finished configuring MacOS defaults. NOTE: A restart is needed"
  code_as_default_text_editor
  success "Finished setting up VSCode as default text editor"
  stow_dotfiles
  success "Finished stowing dotfiles"

  info "======= setting up java ======="
  jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
  jenv add /Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home
  jenv add /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home

  info "======= setting up node ======="
    export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

  nvm install --lts
  nvm install v14.19.1
  nvm install v12.22.12

  ln -s ./plist/com.knollsoft.Rectangle.plist /Users/cboret/Library/Preferences/com.knollsoft.Rectangle.plist 

  info "======= SSH Key ======="
 # setup_github_ssh
  success "Finished setting up SSH Key"

  success "Done"

  info "System needs to restart. Restart?"

  select yn in "y" "n"; do
    case $yn in
        y ) sudo shutdown -r now; break;;
        n ) exit;;
    esac
  done
}

main
