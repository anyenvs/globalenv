function __fish_dcenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'dcenv' ]
    return 0
  end
  return 1
end

function __fish_dcenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c dcenv -n '__fish_dcenv_needs_command' -a '(dcenv commands)'
for cmd in (dcenv commands)
  complete -f -c dcenv -n "__fish_dcenv_using_command $cmd" -a \
    "(dcenv completions (commandline -opc)[2..-1])"
end
