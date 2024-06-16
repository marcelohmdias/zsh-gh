#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'gh' command can not be found
if ! (( $+commands[gh] )); then
    echo "WARNING: 'gh' command not found"
    return
fi

# Completions directory for `gh` command
local COMPLETIONS_DIR="${0:A:h}/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `gh`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_gh" ]]; then
    typeset -g -A _comps
    autoload -Uz _gh
    _comps[gh]=_gh
fi

# Generate and load completion in the background
gh completion --shell zsh >| "$COMPLETIONS_DIR/_gh" &|
