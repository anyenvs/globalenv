function __fish_k9senv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'k9senv' ]
    return 0
  end
  return 1
end

function __fish_k9senv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c k9senv -n '__fish_k9senv_needs_command' -a '(k9senv commands)'
for cmd in (k9senv commands)
  complete -f -c k9senv -n "__fish_k9senv_using_command $cmd" -a \
    "(k9senv completions (commandline -opc)[2..-1])"
end
