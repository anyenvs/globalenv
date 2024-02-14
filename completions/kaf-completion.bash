## Kaf completion
unset POSIXLY_CORRECT
eval which kaf && . <( kaf completion ${SHELL##*/} ) || true
eval which kaf &>/dev/null && grep -q 'kaf completion' $HOME/.bash_completion || echo 'eval which kaf && . <( kaf completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
