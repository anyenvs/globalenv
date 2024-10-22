if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jiraenv jiraenv

_jiraenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jiraenv commands)"
  else
    completions="$(jiraenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
