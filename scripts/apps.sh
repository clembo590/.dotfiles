apps=(
  arduino
  clipy
  deepl
  discord
  docker
  firefox
  google-chrome
  kitty
  rectangle
  slack
  spotify
  typora
  visual-studio-code
  vlc
)

masApps=(
  "937984704"   # Amphetamine
  "1444383602"  # Good Notes 5
  "768053424"   # Gappling (svg viewer)
)

install_macos_apps() {
  info "Installing macOS apps..."
  install_brew_casks "${apps[@]}"
}

install_masApps() {
  info "Installing App Store apps..."
  for app in $masApps; do
    mas install $app
  done
}
