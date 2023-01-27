## Kustomize completion
unset POSIXLY_CORRECT
eval which kustomize && . <( kustomize completion ${SHELL##*/} ) || true
grep -q 'kustomize completion' $HOME/.bash_completion || echo 'eval which kustomize && . <( kustomize completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
