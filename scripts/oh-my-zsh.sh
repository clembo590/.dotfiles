install_oh_my_zsh() {
  ZSH=~/.oh-my-zsh
  if [[ ! -f ~/.zshrc ]]; then
    info "Installing oh my zsh..."
    ZSH=~/.oh-my-zsh ZSH_DISABLE_COMPFIX=true sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    chmod 744 ~/.oh-my-zsh/oh-my-zsh.sh
    
    info "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
  else
    warn "oh-my-zsh already installed"
  fi
}

install_zsh_plugins() {
  info "Installing zsh-z"

  if [[ ! -d "$ZSH/plugins/zsh-z" ]]; then
    git clone https://github.com/agkozak/zsh-z $ZSH/plugins/zsh-z
    success "Installed zsh-z"
  else
    warn "zsh-z already installed"
  fi

  if [[ ! -d "$ZSH/plugins/zsh-syntax-highlighting" ]]; then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting
    success "Installed zsh-syntax-highlighting"
  else
    warn "zsh-syntax-highlighting already installed"
  fi

  if [[ ! -d "$ZSH/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions
    success "Installed zsh-autosuggestions"
  else
    warn "zsh-autosuggestions already installed"
  fi


  if [[ ! -d "$ZSH/custom/plugins/command-time" ]]; then
    git clone https://github.com/popstas/zsh-command-time.git $ZSH/custom/plugins/command-time
    success "Installed command-time"
  else
    warn "command-time already installed"
  fi






}

