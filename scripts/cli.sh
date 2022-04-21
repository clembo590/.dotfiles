install_python_packages() {
  info "Installing pip"
  curl https://bootstrap.pypa.io/get-pip.py | python3

  info "Installing pip xkcdpass"
  pip install xkcdpass
}

