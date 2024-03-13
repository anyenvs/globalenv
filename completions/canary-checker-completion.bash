## canary-checker Cli completion
eval which canary-checker && . <( canary-checker completion ${SHELL##*/} ) || true
grep -q 'canary-checker completion' $HOME/.bash_completion || echo 'eval which canary-checker && . <( canary-checker completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
