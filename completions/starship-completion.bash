
## StarShip Cli completion
eval which starship && . <( starship completions ${SHELL##*/} ) || true
eval which starship >/dev/null && grep -q 'starship completions' $HOME/.bash_completion || echo 'eval which starship && . <( starship completions ${SHELL##*/} )' >> $HOME/.bash_completion

true
