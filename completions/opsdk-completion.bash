. <( operator-sdk completion bash ) || true
. <( ansible-operator completion bash ) || true
. <( helm-operator completion bash ) || true
complete -o default -F __start_ansible-operator ansiblesdk
complete -o default -F __start_operator-sdk opsdk
complete -o default -F __start_helm-operator helmsdk
