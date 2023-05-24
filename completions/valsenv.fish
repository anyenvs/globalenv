function __fish_valsenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'valsenv' ]
    return 0
  end
  return 1
end

function __fish_valsenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c valsenv -n '__fish_valsenv_needs_command' -a '(valsenv commands)'
for cmd in (valsenv commands)
  complete -f -c valsenv -n "__fish_valsenv_using_command $cmd" -a \
    "(valsenv completions (commandline -opc)[2..-1])"
end
