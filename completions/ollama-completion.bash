## Ollama completion
unset POSIXLY_CORRECT
#eval which ollama && . <( ollama completion ${SHELL##*/} ) || true
#eval which ollama &>/dev/null && grep -q 'ollama completion' $HOME/.bash_completion || echo 'eval which ollama && . <( ollama completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
