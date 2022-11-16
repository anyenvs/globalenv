if [[ ! -o interactive ]]; then
    return
fi

compctl -K _opsdkenv opsdkenv

_opsdkenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(opsdkenv commands)"
  else
    completions="$(opsdkenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
