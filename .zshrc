# ~/.zshrc - Customized for Vim bindings, advanced completion, and persistent history
# zmodload zsh/zprof

# Enable colors and improved prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}[%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[red]%}%M %{$fg[magenta]%}%~%{$fg[blue]%}]%{$reset_color%}$%b "

# Aliases
# alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias svim='sudo nvim'
alias ls='lsd -F'
alias l1='lsd -1 -F'
alias la='lsd -a'
alias lt='lsd --tree -F'
alias l='lsd -F'
alias ll='lsd -latrh'
alias tt='ttyper -w 10'
alias leet='nvim leetcode.nvim'
alias cat='bat -p'
alias cd='z'
alias zz='z -'
alias ss='sudo systemctl'

# Persistent and shared history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS

# Advanced tab completion
autoload -Uz compinit && compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Vim-like keybindings
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Cursor shape change for vi mode
function zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;  # Block cursor for normal mode
    viins|main|'') echo -ne '\e[5 q';;  # Beam cursor for insert mode
  esac
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  echo -ne "\e[5 q"
}
zle -N zle-line-init
preexec() { echo -ne '\e[5 q'; }


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

jrun() {
    if [ $# -lt 1 ]; then
        echo "Usage: jrun <JavaFile.java> [args...]"
        return 1
    fi

    JAVA_FILE=$1

    if [[ ! -f "$JAVA_FILE" || "${JAVA_FILE##*.}" != "java" ]]; then
        echo "Error: '$JAVA_FILE' is not a valid Java file."
        return 1
    fi

    javac "$JAVA_FILE"
    if [ $? -ne 0 ]; then
        echo "Compilation failed."
        return 1
    fi

    CLASS_NAME="${JAVA_FILE%.java}"

    java "$CLASS_NAME" "$@"

    EXIT_STATUS=$?

    rm -f "${CLASS_NAME}.class"

    return $EXIT_STATUS
}

crun() {
    if [ -z "$1" ]; then
        echo "Usage: crun <C file> [program arguments]"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: File '$1' does not exist."
        return 1
    fi

    local filename=$(basename -- "$1")
    local output_file="${filename%.*}.out"

    gcc "$1" -o "$output_file" 2> compile_errors.log
    if [ $? -ne 0 ]; then
        echo "Compilation failed. See errors below:"
        cat compile_errors.log
        rm -f compile_errors.log
        return 1
    fi

    rm -f compile_errors.log

    echo "Compilation successful. Running the program..."
    echo "----------------------------------------------"
    ./"$output_file" "${@:2}"

    rm -f "$output_file"

    return 0
}

# Edit command line in Vim using Ctrl+E
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Environment variables
export EDITOR=nvim
export TERMINAL=kitty
export MANPAGER='nvim +Man!'
export PATH="$PATH:$HOME/.local/bin:$HOME/.lmstudio/bin:usr/bin/flutter/bin"

# Load starship prompt
eval "$(starship init zsh)"

# Load zoxide
eval "$(zoxide init zsh)"

# Load fastfetch
fastfetch

# Load Rust environment
. "$HOME/.cargo/env"

# Load Zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Load nvm
# source /usr/share/nvm/init-nvm.sh

# Lazy-load nvm
nvm() {
    unset -f nvm
    source /usr/share/nvm/init-nvm.sh
    nvm "$@"
}

node() {
    unset -f node
    source /usr/share/nvm/init-nvm.sh
    node "$@"
}

npm() {
    unset -f npm
    source /usr/share/nvm/init-nvm.sh
    npm "$@"
}

npx() {
    unset -f npx
    source /usr/share/nvm/init-nvm.sh
    npx "$@"
}

# Load plugins via Zinit
# zinit light zsh-users/zsh-autosuggestions
# zinit light zdharma-continuum/fast-syntax-highlighting

zinit wait'0' silent for \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting

# Load a few important annexes, without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# zprof
