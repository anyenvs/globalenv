eval which operator-sdk && . <( operator-sdk completion ${SHELL##*/} ) || true
eval which helm-operator && . <( helm-operator completion ${SHELL##*/} ) || true
eval which ansible-operator && . <( ansible-operator completion ${SHELL##*/} ) || true
type -t __start_ansible-operator &>/dev/null && complete -o default -F __start_ansible-operator ansiblesdk
type -t __start_helm-operator &>/dev/null && complete -o default -F __start_helm-operator helmsdk
type -t __start_operator-sdk &>/dev/null && complete -o default -F __start_operator-sdk opsdk
true
