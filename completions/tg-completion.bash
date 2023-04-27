ANYENV_ROOT=$HOME/.anyenv
TFENV_ROOT=$HOME/.tfenv
GLOBALENV_ROOT=$HOME/.globalenv
ANYENV_PATHS="${ANYENV_ROOT}/bin:${GLOBALENV_ROOT}/bin:${GLOBALENV_ROOT}/shims:${TFENV_ROOT}/bin:${TFENV_ROOT}/shims"
PATH=$(echo -n "$HOME/bin:$HOME/.local/bin:${ANYENV_PATHS}:$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

## Terragrunt Completions
TG_COMMANDS=$( terragrunt | sed -n '/COMMANDS/,/^$/p' | grep -vE '\*|COMMANDS' | awk '{ print $1 }' )
TG_OPTIONS=$( terragrunt | sed -n '/GLOBAL OPTIONS/,/^$/p' | grep -vE 'GLOBAL OPTIONS' | awk '{ print $1 }' | xargs -n1 -I{} echo --{} )

## Terraform Completions
TF_COMMANDS_ALL="$( terraform --help )"
TF_COMMANDS=$( echo "$TF_COMMANDS_ALL" | sed -n '/Main commands/,/^$/p' | grep -vE 'Main commands' | awk '{ print $1 }' )
TF_OTHER_COMMANDS=$( echo "$TF_COMMANDS_ALL" | sed -n '/All other commands/,/^$/p' | grep -vE 'All other commands' | awk '{ print $1 }' )
TF_OPTIONS=$( echo "$TF_COMMANDS_ALL" | sed -n '/Global options/,/^$/p' | grep -vE 'Global options' | awk '{ print $1 }' )

test -z "$( which terragrunt )" || complete -W "$( echo $TG_COMMANDS $TG_OPTIONS $TF_COMMANDS $TF_OTHER_COMMANDS $TF_OPTIONS | xargs)" terragrunt tg tg-debug tg-run-all-debug
test -z "$( which terragrunt )" || complete -W "$( echo $TG_COMMANDS $TG_OPTIONS $TF_COMMANDS $TF_OTHER_COMMANDS $TF_OPTIONS -pattern= -modules-only -plan +plan -verbose dry-run | xargs)" tgp
test -z "$( which terraform )" || complete -C $(which terraform) terraform t
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
