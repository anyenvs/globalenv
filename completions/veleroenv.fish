function __fish_veleroenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'veleroenv' ]
    return 0
  end
  return 1
end

function __fish_veleroenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c veleroenv -n '__fish_veleroenv_needs_command' -a '(veleroenv commands)'
for cmd in (veleroenv commands)
  complete -f -c veleroenv -n "__fish_veleroenv_using_command $cmd" -a \
    "(veleroenv completions (commandline -opc)[2..-1])"
end
