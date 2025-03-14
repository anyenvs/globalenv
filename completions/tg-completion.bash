ANYENV_ROOT=$HOME/.anyenv
TFENV_ROOT=$HOME/.tfenv
GLOBALENV_ROOT=$HOME/.globalenv
ANYENV_PATHS="${ANYENV_ROOT}/bin:${GLOBALENV_ROOT}/bin:${GLOBALENV_ROOT}/shims:${TFENV_ROOT}/bin:${TFENV_ROOT}/shims"
#PATH=$(echo -n "$HOME/bin:$HOME/.local/bin:${ANYENV_PATHS}:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

SED=( $( which {gsed,sed} 2>/dev/null ) )
## Terragrunt Completions
TG_COMMANDS_ALL="$( terragrunt --help )"
TG_COMMANDS=$( terragrunt | $SED -n '/\(COMMAND\|commands\|shortcuts\)/,/^$/p' | grep -vE '\*|COMMANDS|commands:|shortcuts:' | awk '{ print $1 }' )
TG_OPTIONS=$( terragrunt | $SED -n '/\(GLOBAL OPTIONS|Global Options\)/,/^$/p' | grep -vE 'GLOBAL OPTIONS|Global Options' | awk '{ print $1 }' | xargs -I{} echo {} )
TG_OPTIONS_RUN_ALL=$( terragrunt run --help | $SED -n '/\(GLOBAL OPTIONS\|Options\)/,/^$/p' | grep -vE 'GLOBAL OPTIONS|Global Options|Options:' | awk '{ print $1 }' | xargs -I{} echo {} )

## Terraform Completions
TF_COMMANDS_ALL="$( terraform --help )"
TF_MAIN_COMMANDS=$(  echo "$TF_COMMANDS_ALL" | $SED -n '/Main commands/,/^$/p' | grep -vE 'Main commands' | awk '{ print $1 }' )
TF_GLOBAL_OPTIONS=$( echo "$TF_COMMANDS_ALL" | $SED -n '/Global options/,/^$/p' | grep -vE 'Global options' | awk '{ print $1 }' )
TF_OTHER_COMMANDS=$( echo "$TF_COMMANDS_ALL" | $SED -n '/All other commands/,/^$/p' | grep -vE 'All other commands' | awk '{ print $1 }' )
TF_COMMANDS_APPLY=$( terraform apply -help | $SED -n 'H;/Options/h; ${g;p;}' | grep '^  -' | awk '{ print $1 }')
TF_COMMANDS_INIT=$(  terraform init -help  | $SED -n 'H;/Options/h; ${g;p;}' | grep '^  -' | awk '{ print $1 }')
TF_COMMANDS_TAINT=$( terraform taint -help | $SED -n 'H;/Options/h; ${g;p;}' | grep '^  -' | grep -v ',' | awk '{ print $1 }')
TF_COMMANDS_STATE=$( terraform state -help | $SED -n '/Subcommands/,/^$/p' | grep -vE 'Subcommands' | awk '{ print $1 }')
TF_OPTIONS_2="-target -replace -chdir="


test -z "$( which tofu )" || complete -W "$( echo $TF_MAIN_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2 | xargs)" tofu
test -z "$( which terragrunt )" || complete -W "$( echo $TG_COMMANDS $TG_OPTIONS $TG_OPTIONS_RUN_ALL $TF_MAIN_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2 | xargs)" terragrunt tg tg-debug tg-run-all-debug tg-source-update-false
test -z "$( which terragrunt )" || complete -W "$( echo $TG_COMMANDS $TG_OPTIONS $TG_OPTIONS_RUN_ALL $TF_MAIN_COMMANDS $TF_OTHER_COMMANDS $TF_GLOBAL_OPTIONS $TF_COMMANDS_APPLY $TF_COMMANDS_INIT $TF_COMMANDS_TAINT $TF_COMMANDS_STATE $TF_OPTIONS_2 -pattern= -modules-only -plan +plan -verbose dry-run | xargs)" tgp
test -z "$( which terraform )"  || { complete -C $(which terraform) terraform t ; echo complete -W "$TF_OPTIONS_2" terraform t ; }
set +x

_terraform() {
  local cmds cur colonprefixes;
  COMPREPLY=();
  if [[ "${COMP_WORDS[$COMP_CWORD]}" =~ ^-target= ]]; then
    cmds=$(grep -hE "^ *(module|resource)" *.tf | tr -d '"'| awk '
      $1 ~ /module/ {print "-target="$1"."$2};
      $1 ~ /resource/ { print "-target="$2"."$3}
    ')
  else
    cmds=$(terraform --help ${COMP_WORDS[1]} | awk '
    {
      if (comm && $1 != "") {
        print $1
      };
      if (opt && $1 ~ /^-/) {
        split($1, sopt, "=", seps);
        printf("%s%s\n", sopt[1], seps[1])
      };
      if ($0 ~ /^Available (sub)?commands/) {
        comm=1
        opt=0
      };
      if ($0 ~ /^(Common (sub)?|All other)commands/) {
        comm=1
        opt=0
      };
      if ($0 ~ /^Options/) {
        opt=1
        comm=0
      }
    }')
  fi
  cur=${COMP_WORDS[$COMP_CWORD]}
  colonprefixes=${cur%"${cur##*:}"};
  COMPREPLY=( $(compgen -W '$cmds'  -- $cur));
  if [[ $cur =~ ^- ]]; then
    compopt -o nospace
  fi
  local i=${#COMPREPLY[*]};
  while [ $((--i)) -ge 0 ]; do
    COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"};
  done;
  return 0;
set +x ; } #&& complete -F _terraform terragrunt tg
