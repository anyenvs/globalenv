## JFrog Cli completion
eval which jf && jf completion ${SHELL##*/} --install && . ~/.jfrog/jfrog_${SHELL##*/}_completion
grep -q 'jf completion' $HOME/.bash_completion || echo 'eval which jf && jf completion ${SHELL##*/} --install && . ~/.jfrog/jfrog_${SHELL##*/}_completion )' >> $HOME/.bash_completion

true
