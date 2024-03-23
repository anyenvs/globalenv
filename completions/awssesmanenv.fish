function __fish_awssesmanenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'awssesmanenv' ]
    return 0
  end
  return 1
end

function __fish_awssesmanenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c awssesmanenv -n '__fish_awssesmanenv_needs_command' -a '(awssesmanenv commands)'
for cmd in (awssesmanenv commands)
  complete -f -c awssesmanenv -n "__fish_awssesmanenv_using_command $cmd" -a \
    "(awssesmanenv completions (commandline -opc)[2..-1])"
end
