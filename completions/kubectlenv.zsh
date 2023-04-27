if [[ ! -o interactive ]]; then
    return
fi

compctl -K _kubectlenv kubectlenv

_kubectlenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(kubectlenv commands)"
  else
    completions="$(kubectlenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
