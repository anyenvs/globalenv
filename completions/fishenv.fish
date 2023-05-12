function __fish_fishenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'fishenv' ]
    return 0
  end
  return 1
end

function __fish_fishenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c fishenv -n '__fish_fishenv_needs_command' -a '(fishenv commands)'
for cmd in (fishenv commands)
  complete -f -c fishenv -n "__fish_fishenv_using_command $cmd" -a \
    "(fishenv completions (commandline -opc)[2..-1])"
end
