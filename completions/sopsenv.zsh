if [[ ! -o interactive ]]; then
    return
fi

compctl -K _sopsenv sopsenv

_sopsenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(sopsenv commands)"
  else
    completions="$(sopsenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
