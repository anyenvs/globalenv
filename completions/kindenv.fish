function __fish_kindenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'kindenv' ]
    return 0
  end
  return 1
end

function __fish_kindenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c kindenv -n '__fish_kindenv_needs_command' -a '(kindenv commands)'
for cmd in (kindenv commands)
  complete -f -c kindenv -n "__fish_kindenv_using_command $cmd" -a \
    "(kindenv completions (commandline -opc)[2..-1])"
end