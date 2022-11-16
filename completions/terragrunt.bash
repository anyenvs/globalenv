_terraform() {
  set -x
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
 set +x ; } && complete -F _terraform terragrunt tg
