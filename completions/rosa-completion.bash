## ROSA Cli completion
eval which rosa && . <( rosa completion ${SHELL##*/} ) || true
grep -q 'rosa completion' $HOME/.bash_completion || echo 'eval which rosa && . <( rosa completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
