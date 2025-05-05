#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias svim='sudo nvim'
alias la='ls -a'
alias l='ls'
alias ll='ls -latr'
alias cd='z'
alias cpy='history -a && kitty &'

alias leet='nvim leetcode.nvim'

alias tt='ttyper -w 10'

alias lid-open='systemd-inhibit --what=handle-lid-switch sleep 1h'

PS1='\[\033[1;34m\][\u@\h \[\033[1;32m\]\W\[\033[1;34m\]]\[\033[0m\]\$ '

export EDITOR=nvim
export TERMINAL=kitty
export MANPAGER='nvim +Man!'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
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

eval "$(starship init bash)"
eval "$(zoxide init bash)"
fastfetch

. "$HOME/.cargo/env"

# Created by `pipx` on 2025-01-22 17:36:29
export PATH="$PATH:/home/ysh/.local/bin"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/ysh/.lmstudio/bin"

export PATH="$PATH:usr/bin/flutter/bin"
