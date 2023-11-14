set ANYENV_ROOT $HOME/.anyenv
set TFENV_ROOT $HOME/.tfenv
set GLOBALENV_ROOT $HOME/.globalenv
set ANYENV_PATHS "$ANYENV_ROOT/bin" "$GLOBALENV_ROOT/bin" "$GLOBALENV_ROOT/shims" "$TFENV_ROOT/bin" "$TFENV_ROOT/shims"
set PATH $(echo -n "$HOME/bin:$HOME/.local/bin:$ANYENV_PATHS:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

## Terragrunt Completions
set TG_COMMANDS_ALL ( terragrunt --help | string split0)
set TG_COMMANDS ( echo "$TG_COMMANDS_ALL" | sed -n '/COMMANDS/,/^$/p' | grep -vE '\*|COMMANDS' | awk '{ print $1 }' )
set TG_OPTIONS  ( echo "$TG_COMMANDS_ALL" | sed -n '/GLOBAL OPTIONS/,/^$/p' | grep -vE 'GLOBAL OPTIONS' | awk '{ print $1 }' | xargs -n1 -I{} echo --{} )

## Terraform Completions
set TF_COMMANDS_ALL   ( terraform --help  | string split0)
set TF_MAIN_COMMANDS  ( echo "$TF_COMMANDS_ALL" | sed -n '/Main commands/,/^$/p' | grep -vE 'Main commands' | awk '{ print $1 }' )
set TF_GLOBAL_OPTIONS ( echo "$TF_COMMANDS_ALL" | sed -n '/Global options/,/^$/p' | grep -vE 'Global options' | awk '{ print $1 }' )
set TF_OTHER_COMMANDS ( echo "$TF_COMMANDS_ALL" | sed -n '/All other commands/,/^$/p' | grep -vE 'All other commands' | awk '{ print $1 }' )
set TF_COMMANDS_APPLY ( terraform apply -help | string split0 | sed -n 'H;/Options/h; ${g;p;}' | grep '^  \-' | awk '{ print $1 }')
set TF_COMMANDS_INIT  ( terraform init -help | string split0  | sed -n 'H;/Options/h; ${g;p;}' | grep '^  \-' | awk '{ print $1 }')
set TF_COMMANDS_TAINT ( terraform taint -help | string split0 | sed -n 'H;/Options/h; ${g;p;}' | grep '^  \-' | grep -v ',' | awk '{ print $1 }')
set TF_COMMANDS_STATE ( terraform state -help | string split0 | sed -n '/Subcommands/,/^$/p' | grep -vE 'Subcommands' | awk '{ print $1 }')
set TF_OPTIONS_2 "-target -replace"

function __fish_terragrunt_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'terragrunt' ]
    return 0
  end
  return 1
end

function __fish_terragrunt_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

test -z ( which terragrunt ) || complete -f -c terragrunt -n '__fish_terragrunt_needs_command' -a "$TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
test -z ( which tofu ) || complete -f -c terragrunt -n '__fish_terragrunt_needs_command' -a "$TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
## tg aliases
complete -c tg -w terragrunt
complete -c tg-debug -w terragrunt
complete -c tg-run-all-debug -w terragrunt
for cmd in (echo $TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2 | xargs)
  complete -f -c terragrunt -n "__fish_terragrunt_using_command $cmd" -a "$TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
  complete -f -c tg -n "__fish_terragrunt_using_command $cmd" -a "$TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
  complete -f -c tg-debug -n "__fish_terragrunt_using_command $cmd" -a "$TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
  complete -f -c tg-run-all-debug -n "__fish_terragrunt_using_command $cmd" -a "$TG_COMMANDS $TG_OPTIONS $TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
end
## tgp alias
complete -c tgp -w terragrunt -a "-pattern= -modules-only -plan +plan -verbose dry-run $TF_OPTIONS_2"
for cmd in (echo $TG_COMMANDS $TG_OPTIONS $TF_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS | xargs)
  complete -f -c tgp -n "__fish_terragrunt_using_command $cmd" -a "$TG_OPTIONS $TF_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS -pattern= -modules-only -plan +plan -verbose dry-run"
end
## tofu alias
for cmd in (echo $TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2 | xargs)
  complete -f -c tofu -n "__fish_terragrunt_using_command $cmd" -a "$TF_MAIN_COMMANDS $TF_GLOBAL_OPTIONS $TF_OTHER_COMMANDS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2"
end

function __fish_terraform_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'terraform' ]
    return 0
  end
  return 1
end

function __fish_terraform_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end
test -z ( which terraform )  || complete -f -c terraform -n '__fish_terraform_needs_command' -a "$TF_COMMANDS $TF_OTHER_COMMANDS"
for cmd in (echo $TF_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS | xargs)
  complete -f -c terraform -n "__fish_terraform_using_command $cmd" -a "$TF_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE -replace -target -auto-approve -compact-warnings -lock=false -lock-timeout=0s"
end
## aliases
complete -f -c t -w terraform
