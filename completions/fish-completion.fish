complete -c fish -s c -l command -d "Run specified command instead of interactive session" -x -a "(__fish_complete_command)"
complete -c fish -s C -l init-command -d "Run specified command before session" -x -a "(__fish_complete_command)"
complete -c fish -s h -l help -d "Display help and exit"
complete -c fish -s v -l version -d "Display version and exit"
complete -c fish -s N -l no-config -d "Do not read configuration files"
complete -c fish -s n -l no-execute -d "Only parse input, do not execute"
complete -c fish -s i -l interactive -d "Run in interactive mode"
complete -c fish -s l -l login -d "Run as a login shell"
complete -c fish -s p -l profile -d "Output profiling information (excluding startup) to a file" -r
complete -c fish -l profile-startup -d "Output startup profiling information to a file" -r
complete -c fish -s d -l debug -d "Specify debug categories" -x -a "(fish --print-debug-categories | string replace ' ' \t)"
complete -c fish -s o -l debug-output -d "Where to direct debug output to" -rF
complete -c fish -s P -l private -d "Do not persist history"

function __fish_complete_features
    set -l arg_comma (commandline -tc | string replace -rf '(.*,)[^,]*' '$1' | string replace -r -- '--.*=' '')
    set -l features (status features | string replace -rf '^([\w-]+).*\t(.*)$' '$1\t$2')
    printf "%s\n" "$arg_comma"$features #TODO: remove existing args
end
complete -c fish -s f -l features -d "Run with comma-separated feature flags enabled" -a "(__fish_complete_features)" -x
complete -c fish -l print-rusage-self -d "Print stats from getrusage at exit" -f
complete -c fish -l print-debug-categories -d "Print the debug categories fish knows" -f

complete -c fish -k -x -a "(__fish_complete_suffix .fish)"
complete -c fish_add_path -s a -l append -d 'Add path to the end'
complete -c fish_add_path -s p -l prepend -d 'Add path to the front (default)'
complete -c fish_add_path -s g -l global -d 'Use a global $fish_user_paths'
complete -c fish_add_path -s U -l universal -d 'Use a universal $fish_user_paths (default)'
complete -c fish_add_path -s P -l path -d 'Update $PATH directly'
complete -c fish_add_path -s m -l move -d 'Move path to the front or back'
complete -c fish_add_path -s v -l verbose -d 'Print the set command used'
complete -c fish_add_path -s n -l dry-run -d 'Print the set command without executing it'
complete -c fish_add_path -s h -l help -d 'Display help and exit'
complete fish_config -f
set -l prompt_commands choose save show list
set -l theme_commands choose demo dump save show list
complete fish_config -n __fish_use_subcommand -a prompt -d 'View and pick from the sample prompts'
complete fish_config -n "__fish_seen_subcommand_from prompt; and not __fish_seen_subcommand_from $prompt_commands" \
    -a choose -d 'View and pick from the sample prompts'
complete fish_config -n "__fish_seen_subcommand_from prompt; and not __fish_seen_subcommand_from $prompt_commands" \
    -a show -d 'Show what prompts would look like'
complete fish_config -n "__fish_seen_subcommand_from prompt; and not __fish_seen_subcommand_from $prompt_commands" \
    -a list -d 'List all available prompts'
complete fish_config -n "__fish_seen_subcommand_from prompt; and not __fish_seen_subcommand_from $prompt_commands" \
    -a save -d 'Save the current or given prompt to ~/.config/fish'
complete fish_config -n '__fish_seen_subcommand_from prompt; and __fish_seen_subcommand_from choose save show' -a '(fish_config prompt list)'

complete fish_config -n __fish_use_subcommand -a browse -d 'Open the web-based UI'

complete fish_config -n __fish_use_subcommand -a theme -d 'View and pick from the sample themes'
complete fish_config -n '__fish_seen_subcommand_from theme; and __fish_seen_subcommand_from choose save show' -a '(fish_config theme list)'
complete fish_config -n "__fish_seen_subcommand_from theme; and not __fish_seen_subcommand_from $theme_commands" \
    -a choose -d 'View and pick from the sample themes'
complete fish_config -n "__fish_seen_subcommand_from theme; and not __fish_seen_subcommand_from $theme_commands" \
    -a show -d 'Show what theme would look like'
complete fish_config -n "__fish_seen_subcommand_from theme; and not __fish_seen_subcommand_from $theme_commands" \
    -a list -d 'List all available themes'
complete fish_config -n "__fish_seen_subcommand_from theme; and not __fish_seen_subcommand_from $theme_commands" \
    -a save -d 'Save the given theme as universal variables'
complete fish_config -n "__fish_seen_subcommand_from theme; and not __fish_seen_subcommand_from $theme_commands" \
    -a demo -d 'Show example in the current theme'
complete fish_config -n "__fish_seen_subcommand_from theme; and not __fish_seen_subcommand_from $theme_commands" \
    -a dump -d 'Print the current theme in .theme format'
complete -c fish_delta -f -a '(path filter -rf -- $fish_function_path/*.fish $fish_complete_path/*.fish $__fish_vendor_confdirs/*.fish |
path basename | path change-extension "") config'

complete -c fish_delta -s c -l no-completions -d 'Ignore completions'
complete -c fish_delta -s f -l no-functions -d 'Ignore function files'
complete -c fish_delta -s C -l no-config -d 'Ignore config files'
complete -c fish_delta -s d -l no-diff -d 'Don\'t display the full diff'
complete -c fish_delta -s n -l new -d 'Include new files'
complete -c fish_delta -s V -l vendor -d 'Choose how to count vendor files' -xa 'ignore\t"Skip vendor files" user\t"Count vendor files as belonging to the user" default\t"Count vendor files as fish defaults"'
complete -c fish_indent -s h -l help -d 'Display help and exit'
complete -c fish_indent -s v -l version -d 'Display version and exit'
complete -c fish_indent -s i -l no-indent -d 'Do not indent output, only reformat into one job per line'
complete -c fish_indent -l ansi -d 'Colorize the output using ANSI escape sequences'
complete -c fish_indent -l html -d 'Output in HTML format'
complete -c fish_indent -s w -l write -d 'Write to file'
complete -c fish_indent -s d -l debug -x -d 'Enable debug at specified verbosity level'
complete -c fish_indent -s o -l debug-output -d "Where to direct debug output to" -rF
complete -c fish_indent -s D -l debug-stack-frames -x -d 'Specify how many stack frames to display in debug messages'
complete -c fish_indent -l dump-parse-tree -d 'Dump information about parsed statements to stderr'
complete -c fish_key_reader -s h -l help -d 'Display help and exit'
complete -c fish_key_reader -s v -l version -d 'Display version and exit'
complete -c fish_key_reader -s c -l continuous -d 'Start a continuous session'
set --local CONDITION '! __fish_seen_argument --short r --long required-val --short o --long optional-val'

complete --command fish_opt --no-files

complete --command fish_opt --short-option h --long-option help --description 'Show help'

complete --command fish_opt --short-option s --long-option short --no-files --require-parameter --description 'Specify short option'
complete --command fish_opt --short-option l --long-option long --no-files --require-parameter --description 'Specify long option'
complete --command fish_opt --long-option longonly --description 'Use only long option'
complete --command fish_opt --short-option o --long-option optional-val -n $CONDITION --description 'Don\'t require value'
complete --command fish_opt --short-option r --long-option required-val -n $CONDITION --description 'Require value'
complete --command fish_opt --long-option multiple-vals --description 'Store all values'
