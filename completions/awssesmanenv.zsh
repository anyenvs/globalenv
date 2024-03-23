if [[ ! -o interactive ]]; then
    return
fi

compctl -K _awssesmanenv awssesmanenv

_awssesmanenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(awssesmanenv commands)"
  else
    completions="$(awssesmanenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
