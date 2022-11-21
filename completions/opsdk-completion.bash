eval which operator-sdk && . <( operator-sdk completion bash ) || true
eval which helm-operator && . <( helm-operator completion bash ) || true
eval which ansible-operator && . <( ansible-operator completion bash ) || true
type -t __start_ansible-operator && complete -o default -F __start_ansible-operator ansiblesdk
type -t __start_helm-operator && complete -o default -F __start_helm-operator helmsdk
type -t __start_operator-sdk && complete -o default -F __start_operator-sdk opsdk
