stow_dotfiles() {

  local files=(
    ".gitconfig"
    ".zshrc"
  )
  
  info "Removing existing config files"
  for f in $files; do
    rm -f "$HOME/$f" || true
  done


  local dotfiles="git zsh"
  info "Stowing: $dotfiles"
  stow -d stow --verbose 1 --target $HOME $dotfiles
}