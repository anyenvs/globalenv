## GITHUB CLI completion
unset POSIXLY_CORRECT
eval which gh && . <( gh completion -s ${SHELL##*/} ) || true
grep -q 'gh completion' $HOME/.bash_completion || echo 'eval which gh && . <( gh completion -s ${SHELL##*/} ) || true' >> $HOME/.bash_completion

true
