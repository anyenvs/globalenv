## ArgoCD Cli completion
eval which argocd && . <( argocd completion ${SHELL##*/} ) || true
grep -q 'argocd completion' $HOME/.bash_completion || echo 'eval which argocd && . <( argocd completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
