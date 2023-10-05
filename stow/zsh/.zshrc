MONO_PREFIX="${funcsourcetrace[1]%/*}/setup"

ZSH=$HOME/.oh-my-zsh
ZSH_DISABLE_COMPFIX=true

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful plugins for Rails development with Sublime Text
plugins=(gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search zsh-autosuggestions command-time globalias web-search)

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1
brewNoUpdate(){
    HOMEBREW_NO_AUTO_UPDATE=1 brew install $@
}

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed
export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"



# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"

export PATH="/usr/local/opt/awscli@1/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

alias beyondCompareReset="rm ~/Library/Application\ Support/Beyond\ Compare/registry.dat;"

setopt NO_EXTENDED_GLOB

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$(pyenv root)/shims:${PATH}"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


source $MONO_PREFIX/javasetup
source $MONO_PREFIX/mavensetup
source $MONO_PREFIX/npmsetup
source $MONO_PREFIX/dockersetup
source $MONO_PREFIX/gcloudsetup
source $MONO_PREFIX/gitsetup
source $MONO_PREFIX/nvmsetup
source $MONO_PREFIX/mavenAndGitSetup
source $MONO_PREFIX/various
source $MONO_PREFIX/awsSetup

# Load Angular CLI autocompletion.
#source <(ng completion script)

#this is to introduce a small delay before "exectution of a shortcut" (to 'wait for another key stroke')
KEYTIMEOUT=400

# this is shortcuts about auto suggestion plugin
bindkey '^ ' autosuggest-execute
bindkey '^x' autosuggest-clear

# when using CTRL ('^')   (CTRL+A = '^A') the case is NOT SENSITIVE
# when using ALT ('\e')   (ALT+A = '\eA')    the case is SENSITIVE (and in mac terminal that is annoying!!!)

# '^[G' is same as '\eG' (it s just another way of writing it THAT HAS NOTHING TO DO WITH CTRL)
bindkey -s '^gf' '^U git fetch --all --prune '
bindkey -s '^gfu' '^gf ; gitRebaseOriginMainIfNoConflict '
bindkey -s '^gacp' '^U gitAutoCommitAndPush'
bindkey -s '^gcp' '^U gitCommitAndPush'
bindkey -s '^gc' '^U myGitCommit'
bindkey -s '^gsf' "^U git submodule foreach '^B'"

# bindkey -s '^g' '^Ugit status^M'
# bindkey -s '^[G' '^Uecho hello; git status^M'


# BEGIN : THESE ARE CONFIGURATION ABOUT THE COMMAND-TIME PLUGIN
# If command execution time above min. time, plugins will not output time.
ZSH_COMMAND_TIME_MIN_SECONDS=3

# Message to display (set to "" for disable).
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"

# Message color.
ZSH_COMMAND_TIME_COLOR="cyan"

# Exclude some commands
ZSH_COMMAND_TIME_EXCLUDE=(vim mcedit)

# END : THESE ARE CONFIGURATION ABOUT THE COMMAND-TIME PLUGIN






eval $(thefuck --alias)

