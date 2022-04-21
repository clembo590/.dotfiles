install_packages() {
  info "installing brew packages"
  brew bundle --file Brewfile

  info "Cleaning up brew packages..."
  brew cleanup
}
