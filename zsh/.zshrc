# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git cp colorize common-aliases gnu-utils zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias nv='nvim'
alias ra='ranger'

# set proxy
alias goproxy="export http_proxy=10.100.61.105:1082 && export https_proxy=10.100.61.105:1082"
alias unproxy="unset http_proxy && unset https_proxy"


############ setup by OSTYPE start #############
######## macOS ########
if [[ "$OSTYPE" == "darwin"* ]]; then
echo "Running .zshrc on macOS"

# bat
if which bat &> /dev/null; then
  export BAT_THEME="TwoDark"
  _BAT=$(which bat)
  alias cat="${_BAT} -Pp"
  alias less="${_BAT}"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# homebrew shell completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# fzf installed by brew, verion larger than 0.48.0
source <(fzf --zsh)


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


######## Linux ########
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
echo "Running .zshrc on Linux"

# bat
if which batcat &> /dev/null; then
  export BAT_THEME="TwoDark"
  _BAT=$(which batcat)
  alias cat="${_BAT} -pp"
  alias less="${_BAT}"
  export MANPAGER="sh -c 'col -bx | batcat -l man -pp'"
fi

unalias rm &> /dev/null
unalias cp &> /dev/null
unalias fd &> /dev/null
unalias "..." &> /dev/null

export GOPATH=$HOME/.local
export PATH=/opt/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:/opt/darwin/bin:$PATH

function source_file() {
  args=("$@")
  while [ $#args -gt 0 ]; do
    file="${args[1]}"
    args=(${args[@]:1})
    if [[ -e "${file}" ]]; then
      source "$file"
    fi
  done
}
source_file /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source_file "${HOME}/.mytoken.sh"

export GLOG_alsologtostderr=1

# neovim
export PATH="$PATH:/opt/nvim-linux64/bin"

# fzf install by git
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fi
############ setup by OSTYPE end #############

# fzf with preview --preview 'bat -n --color=always {}'
export FZF_DEFAULT_OPTS="--height 60% --layout reverse --border top"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
