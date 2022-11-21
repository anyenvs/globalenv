function __fish_globalenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'globalenv' ]
    return 0
  end
  return 1
end

function __fish_globalenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c globalenv -n '__fish_globalenv_needs_command' -a '(globalenv commands)'
for cmd in (globalenv commands)
  complete -f -c globalenv -n "__fish_globalenv_using_command $cmd" -a \
    "(globalenv completions (commandline -opc)[2..-1])"
end
