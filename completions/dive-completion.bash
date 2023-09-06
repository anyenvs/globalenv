## DIVE Completions
DIVE_COMMANDS_ALL="$( dive --help )"
DIVE_COMMANDS=$( echo "$DIVE_COMMANDS_ALL" | sed -n '/Commands:/,/^$/p' | grep -vE '\*|Commands:' | awk -F '[ ,]*' '{print $2}' )
DIVE_GLOBAL_OPTIONS=$( echo "$DIVE_COMMANDS_ALL" | sed -n '/Flags:/,/^$/p' | grep -vE 'Flags:' | awk -F '[ ,]*' '{print $2}' )
DIVE_ADD_OPTIONS="h -d -e -r -k -p -a -i -s -h -v"

test -z "$( which dive )" || complete -W "$( echo $DIVE_COMMANDS $DIVE_GLOBAL_OPTIONS $DIVE_ADD_OPTIONS | xargs)" dive

true
set +x
