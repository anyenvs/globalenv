function __fish_ollamaenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'ollamaenv' ]
    return 0
  end
  return 1
end

function __fish_ollamaenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c ollamaenv -n '__fish_ollamaenv_needs_command' -a '(ollamaenv commands)'
for cmd in (ollamaenv commands)
  complete -f -c ollamaenv -n "__fish_ollamaenv_using_command $cmd" -a \
    "(ollamaenv completions (commandline -opc)[2..-1])"
end
