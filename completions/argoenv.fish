function __fish_argoenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'argoenv' ]
    return 0
  end
  return 1
end

function __fish_argoenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c argoenv -n '__fish_argoenv_needs_command' -a '(argoenv commands)'
for cmd in (argoenv commands)
  complete -f -c argoenv -n "__fish_argoenv_using_command $cmd" -a \
    "(argoenv completions (commandline -opc)[2..-1])"
end
