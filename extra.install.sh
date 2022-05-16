#!/usr/bin/zsh

  source ~/.zshrc

  info "======= setting up java ======="
  jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
  jenv add /Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home
  jenv add /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home

  info "======= setting up node ======="
  nvm install --lts
  nvm install v14.19.1
  nvm install v12.22.12

