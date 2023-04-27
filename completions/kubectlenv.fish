function __fish_kubectlenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'kubectlenv' ]
    return 0
  end
  return 1
end

function __fish_kubectlenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c kubectlenv -n '__fish_kubectlenv_needs_command' -a '(kubectlenv commands)'
for cmd in (kubectlenv commands)
  complete -f -c kubectlenv -n "__fish_kubectlenv_using_command $cmd" -a \
    "(kubectlenv completions (commandline -opc)[2..-1])"
end
