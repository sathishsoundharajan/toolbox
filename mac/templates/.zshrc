########################
# Antigen
########################
source ~/.antigen/antigen.zsh
source ~/.zsh-themes/ghostwheel.theme

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle StackExchange/blackbox
antigen bundle brew
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle golang
antigen bundle npm
antigen bundle nvm
antigen bundle python
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle zsh-users/zsh-autosuggestions
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply

ZSH_THEME="powerlevel9k/powerlevel9k"