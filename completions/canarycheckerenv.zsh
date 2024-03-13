if [[ ! -o interactive ]]; then
    return
fi

compctl -K _canarycheckerenv canarycheckerenv

_canarycheckerenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(canarycheckerenv commands)"
  else
    completions="$(canarycheckerenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
