stow_dotfiles() {

  local files=(
    .gitconfig
    .zshrc
    .zsh_history
  )
  
  info "Removing existing config files"
  for f in $files; do
    echo remove "$HOME/$f";
    rm -f "$HOME/$f" 
  done

  rm -f $HOME/.gitconfig;
  rm -f $HOME/.zshrc;
  rm -f $HOME/.zsh_history;


  local dotfiles="git zsh"
  info "Stowing: $dotfiles"
  stow -d stow --target $HOME $dotfiles
}