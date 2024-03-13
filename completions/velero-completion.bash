## Velero completion
unset POSIXLY_CORRECT
eval which velero && . <( velero completion ${SHELL##*/} ) || true
eval which velero &>/dev/null && grep -q 'velero completion' $HOME/.bash_completion || echo 'eval which velero && . <( velero completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
