if [[ ! -o interactive ]]; then
    return
fi

compctl -K _easyrsaenv easyrsaenv

_easyrsaenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(easyrsaenv commands)"
  else
    completions="$(easyrsaenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
