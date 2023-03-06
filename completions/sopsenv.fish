function __fish_sopsenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'sopsenv' ]
    return 0
  end
  return 1
end

function __fish_sopsenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c sopsenv -n '__fish_sopsenv_needs_command' -a '(sopsenv commands)'
for cmd in (sopsenv commands)
  complete -f -c sopsenv -n "__fish_sopsenv_using_command $cmd" -a \
    "(sopsenv completions (commandline -opc)[2..-1])"
end
