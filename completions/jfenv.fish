function __fish_jfenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'jfenv' ]
    return 0
  end
  return 1
end

function __fish_jfenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c jfenv -n '__fish_jfenv_needs_command' -a '(jfenv commands)'
for cmd in (jfenv commands)
  complete -f -c jfenv -n "__fish_jfenv_using_command $cmd" -a \
    "(jfenv completions (commandline -opc)[2..-1])"
end
