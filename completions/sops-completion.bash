#echo `eval which sops && echo completion not exist`

## SOPS Completions
SOPS_COMMANDS_ALL="$( sops --help )"
SOPS_COMMANDS=$( echo "$SOPS_COMMANDS_ALL" | sed -n '/COMMANDS/,/^$/p' | grep -vE '\*|COMMANDS' | awk -F '[ ,]*' '{print $2}' )
SOPS_GLOBAL_OPTIONS=$( echo "$SOPS_COMMANDS_ALL" | sed -n '/GLOBAL OPTIONS/,/^$/p' | grep -vE 'GLOBAL OPTIONS' | awk -F '[ ,]*' '{print $2}' )
SOPS_ADD_OPTIONS="h -d -e -r -k -p -a -i -s -h -v"

test -z "$( which sops )" || complete -W "$( echo $SOPS_COMMANDS $SOPS_GLOBAL_OPTIONS $SOPS_ADD_OPTIONS | xargs)" sops

true
set +x
