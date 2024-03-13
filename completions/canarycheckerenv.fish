function __fish_canarycheckerenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'canarycheckerenv' ]
    return 0
  end
  return 1
end

function __fish_canarycheckerenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c canarycheckerenv -n '__fish_canarycheckerenv_needs_command' -a '(canarycheckerenv commands)'
for cmd in (canarycheckerenv commands)
  complete -f -c canarycheckerenv -n "__fish_canarycheckerenv_using_command $cmd" -a \
    "(canarycheckerenv completions (commandline -opc)[2..-1])"
end
