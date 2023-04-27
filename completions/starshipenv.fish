function __fish_starshipenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'starshipenv' ]
    return 0
  end
  return 1
end

function __fish_starshipenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c starshipenv -n '__fish_starshipenv_needs_command' -a '(starshipenv commands)'
for cmd in (starshipenv commands)
  complete -f -c starshipenv -n "__fish_starshipenv_using_command $cmd" -a \
    "(starshipenv completions (commandline -opc)[2..-1])"
end
