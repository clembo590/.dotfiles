stow_dotfiles() {
  local dotfiles="git ssh zsh"
  info "Stowing: $dotfiles"
  stow -d stow --verbose 1 --target $HOME $dotfiles
}