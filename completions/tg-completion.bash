ANYENV_ROOT=$HOME/.anyenv
TFENV_ROOT=$HOME/.tfenv
GLOBALENV_ROOT=$HOME/.globalenv
ANYENV_PATHS="${ANYENV_ROOT}/bin:${GLOBALENV_ROOT}/bin:${GLOBALENV_ROOT}/shims:${TFENV_ROOT}/bin:${TFENV_ROOT}/shims"
PATH=$(echo -n "$HOME/bin:$HOME/.local/bin:${ANYENV_PATHS}:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")
test -z "$( which terraform )" || complete -C $(which terraform) terragrunt

