## Kubectl completion
unset POSIXLY_CORRECT
eval which kubectl && . <( kubectl completion ${SHELL##*/} ) || true
eval which kubectl &>/dev/null && grep -q 'kubectl completion' $HOME/.bash_completion || echo 'eval which kubectl && . <( kubectl completion ${SHELL##*/} )' >> $HOME/.bash_completion

complete -o default -o nospace -F __start_kubectl k kimply kw3 kdef ksys kistio kubefed kf pods _pods

true
