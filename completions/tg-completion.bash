ANYENV_ROOT=$HOME/.anyenv
TFENV_ROOT=$HOME/.tfenv
GLOBALENV_ROOT=$HOME/.globalenv
ANYENV_PATHS="${ANYENV_ROOT}/bin:${GLOBALENV_ROOT}/bin:${GLOBALENV_ROOT}/shims:${TFENV_ROOT}/bin:${TFENV_ROOT}/shims"
PATH=$(echo -n "$HOME/bin:$HOME/.local/bin:${ANYENV_PATHS}:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

## Terragrunt Completions
TG_COMMANDS=$( terragrunt | sed -n '/COMMANDS/,/^$/p' | grep -vE '\*|COMMANDS' | awk '{ print $1 }' )
TG_OPTIONS=$( terragrunt | sed -n '/GLOBAL OPTIONS/,/^$/p' | grep -vE '\*|GLOBAL OPTIONS' | awk '{ print $1 }' | xargs -n1 -I{} echo --{} )

## Terraform Completions
TF_COMMANDS_ALL="$( terraform --help )"
TF_COMMANDS=$( echo "$TF_COMMANDS_ALL" | sed -n '/Main commands/,/^$/p' | grep -vE 'Main commands' | awk '{ print $1 }' )
TF_OTHER_COMMANDS=$( echo "$TF_COMMANDS_ALL" | sed -n '/All other commands/,/^$/p' | grep -vE 'All other commands' | awk '{ print $1 }' )
TF_OPTIONS=$( echo "$TF_COMMANDS_ALL" | sed -n '/Global options/,/^$/p' | grep -vE 'Global options' | awk '{ print $1 }' )

test -z "$( which terragrunt )" || complete -W "$TG_COMMANDS $TG_OPTIONS $TF_COMMANDS $TF_OTHER_COMMANDS $TF_OPTIONS" terragrunt tg tg-debug tg-run-all-debug tgp
test -z "$( which terraform )" || complete -C $(which terraform) terraform t
