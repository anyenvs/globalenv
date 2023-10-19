## OC Cli completion
eval which oc && . <( oc completion ${SHELL##*/} ) || true
eval which ocm && . <( ocm completion ${SHELL##*/} ) || true
grep -q 'oc completion' $HOME/.bash_completion || echo 'eval which oc && . <( oc completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
