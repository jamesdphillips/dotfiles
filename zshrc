ZSH=$HOME/.oh-my-zsh
ZSH_THEME="theunraveler"

DISABLE_UPDATE_PROMPT=true
COMPLETION_WAITING_DOTS=true
UPDATE_ZSH_DAYS=2

plugins=(
  battery
  brew
  bundler
  forklift
  gem
  git
  github
  heroku
  env
  lein
  node
  npm
  osx
  pip
  postgres
  python
  rails
  redis-cli
  ruby
  rvm
  tmux
  wd
  zsh-syntax-highlighting
  zsh-autosuggestions
  rust
  cargo
  yarn
)

source $ZSH/oh-my-zsh.sh

# Load our own completion functions
fpath=(~/.zsh/completion $fpath)

# Completion
autoload -U compinit
compinit

# Load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# History settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# Ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# Load RVM if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# EDITOR
export VISUAL=nvim
export EDITOR=$VISUAL

# Dev tools
# export PATH="$PATH:/Developer/usr/bin"

# Chef
export ENCRYPTED_DATA_BAG_SECRET_KEY_PATH="$HOME/encrypted_data_bag_secret"

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

#
# Ruby

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#
# Go

export GOROOT="/usr/local/opt/go/libexec" # go binaries
# export GOPATH="$HOME/go"                # go libs
export PATH="$HOME/go/bin:$PATH"          # go binaries
# export GO111MODULE=on

#
# GPG

export GPG_TTY=$(tty)

#
# Google Cloud

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jamesdphillips/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/jamesdphillips/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jamesdphillips/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/jamesdphillips/google-cloud-sdk/completion.zsh.inc'; fi

#
# Kubernetes

source <(kubectl completion zsh)

#
# Sensu CLI

# export PATH=/Users/jamesdphillips/go/src/github.com/sensu/sensu-go/bin:$PATH
source <(sensuctl completion zsh)

# added by travis gem
[ -f /Users/jamesdphillips/.travis/travis.sh ] && source /Users/jamesdphillips/.travis/travis.sh

#
# Cargo & Rust

export PATH=$PATH:$HOME/.cargo/bin

#
# Yarn

export PATH=$PATH:$HOME/.yarn/bin

#
# node_modules

export NODE_OPTIONS=--max_old_space_size=4096
export PATH="$PATH:./node_modules/.bin"

#
# Z

. `brew --prefix`/etc/profile.d/z.sh

#
# Sensu Dev

export SENSU_INTERNAL_ENVIRONMENT=dev
