## Argo Cli completion
eval which argo && . <( argo completion ${SHELL##*/} ) || true
grep -q 'argo completion' $HOME/.bash_completion || echo 'eval which argo && . <( argo completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
