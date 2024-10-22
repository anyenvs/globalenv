## JIRA Cli completion
eval which jira && . <( jira completion ${SHELL##*/} ) || true
grep -q 'jira completion' $HOME/.bash_completion || echo 'eval which jira && . <( jira completion ${SHELL##*/} )' >> $HOME/.bash_completion

true
