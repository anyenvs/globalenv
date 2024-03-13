ANYENV_ROOT=$HOME/.anyenv
TFENV_ROOT=$HOME/.tfenv
GLOBALENV_ROOT=$HOME/.globalenv
ANYENV_PATHS="${ANYENV_ROOT}/bin:${GLOBALENV_ROOT}/bin:${GLOBALENV_ROOT}/shims"
PATH=$(echo -n "$HOME/bin:$HOME/.local/bin:${ANYENV_PATHS}:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

## VALS Completions
#VALS_COMMANDS_ALL="$( vals --help )"
#VALS_COMMANDS=$( vals | sed -n '/Available Commands/,/^$/p' | grep -vE '\*|Available Commands' | awk '{ print $1 }' )
#VALS_EVAL_OPTIONS=$( vals eval --help | sed -n '/Usage of/,/^$/p' | grep -vE 'Usage of' | awk '{ print $1 }' | xargs -n1 -I{} echo {} )
#VALS_EXEC_OPTIONS=$( vals exec --help | sed -n '/Usage of/,/^$/p' | grep -vE 'Usage of' | awk '{ print $1 }' | xargs -n1 -I{} echo {} )
#VALS_ENV_OPTIONS=$( vals env --help | sed -n '/Usage of/,/^$/p' | grep -vE 'Usage of' | awk '{ print $1 }' | xargs -n1 -I{} echo {} )
#VALS_GET_OPTIONS=$( vals get --help | sed -n '/Usage of/,/^$/p' | grep -vE 'Usage of' | awk '{ print $1 }' | xargs -n1 -I{} echo {} )
#VALS_KSDECODE_OPTIONS=$( vals ksdecode --help | sed -n '/Usage of/,/^$/p' | grep -vE 'Usage of' | awk '{ print $1 }' | xargs -n1 -I{} echo {} )

test -z "$( which vals )" || complete -W "$( echo $VALS_COMMANDS $VALS_EVAL_OPTIONS $VALS_EXEC_OPTIONS $VALS_ENV_OPTIONS $VALS_GET_OPTIONS $VALS_KSDECODE_OPTIONS | xargs)" vals
set +x
