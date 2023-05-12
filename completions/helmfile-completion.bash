ANYENV_ROOT=$HOME/.anyenv
GLOBALENV_ROOT=$HOME/.globalenv
ANYENV_PATHS="${ANYENV_ROOT}/bin:${GLOBALENV_ROOT}/bin:${GLOBALENV_ROOT}/shims"
PATH=$(echo -n "$HOME/bin:$HOME/.local/bin:${ANYENV_PATHS}:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

HELMFILE_VERSION=$(helmfile -v); HELMFILE_VERSION=${HELMFILE_VERSION##* };

## https://unix.stackexchange.com/questions/285924/how-to-compare-a-programs-version-in-a-shell-script/285928#285928
version_greater_equal() {
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

## helmfile completion <= 0.144.0
_helmfile_bash_autocomplete() {
  if [[ "${COMP_WORDS[0]}" != "source" ]]; then
    local cur opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ "$cur" == "-"* ]]; then
      opts=$( ${COMP_WORDS[@]:0:$COMP_CWORD} ${cur} --generate-bash-completion )
    else
      opts=$( ${COMP_WORDS[@]:0:$COMP_CWORD} --generate-bash-completion )
    fi
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
  fi
}
#complete -o bashdefault -o default -o nospace -F _helmfile_bash_autocomplete helmfile
eval which helmfile &>/dev/null && version_greater_equal "${HELMFILE_VERSION}" 0.145.0 || complete -o bashdefault -o default -o nospace -F _helmfile_bash_autocomplete helmfile

## helmfile completion >= 0.145.0
eval which helmfile && version_greater_equal "${HELMFILE_VERSION}" 0.145.0 && . <( helmfile completion ${SHELL##*/} )

## Helpers
## https://prcode.co.uk/2021/10/13/bash-compare-version-numbers/
versionlte() {
    [  "$1" = "`echo -e $1\n$2 | sort -V | head -n1`" ]
}

versionlt() {
    [ "$1" = "$2" ] && return 1 || versionlte $1 $2
}
