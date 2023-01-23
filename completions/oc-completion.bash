## ROSA Cli completion
eval which rosa && . <( rosa completion ${SHELL##*/} ) || true
grep -q 'rosa completion' $HOME/.bash_completion || echo 'eval which rosa && . <( rosa completion ${SHELL##*/} )' >> $HOME/.bash_completion
## OC Cli completion
eval which oc && . <( oc completion ${SHELL##*/} ) || true
grep -q 'oc completion' $HOME/.bash_completion || echo 'eval which oc && . <( oc completion ${SHELL##*/} )' >> $HOME/.bash_completion
## OCM Cli completion
eval which ocm && . <( ocm completion ${SHELL##*/} ) || true
grep -q 'ocm completion' $HOME/.bash_completion || echo 'eval which ocm && . <( ocm completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
