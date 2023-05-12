## Kind completion
unset POSIXLY_CORRECT
eval which kind && . <( kind completion ${SHELL##*/} ) || true
eval which kind &>/dev/null && grep -q 'kind completion' $HOME/.bash_completion || echo 'eval which kind && . <( kind completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
