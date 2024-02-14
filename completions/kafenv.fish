function __fish_kafenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'kafenv' ]
    return 0
  end
  return 1
end

function __fish_kafenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c kafenv -n '__fish_kafenv_needs_command' -a '(kafenv commands)'
for cmd in (kafenv commands)
  complete -f -c kafenv -n "__fish_kafenv_using_command $cmd" -a \
    "(kafenv completions (commandline -opc)[2..-1])"
end
