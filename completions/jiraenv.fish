function __fish_jiraenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'jiraenv' ]
    return 0
  end
  return 1
end

function __fish_jiraenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c jiraenv -n '__fish_jiraenv_needs_command' -a '(jiraenv commands)'
for cmd in (jiraenv commands)
  complete -f -c jiraenv -n "__fish_jiraenv_using_command $cmd" -a \
    "(jiraenv completions (commandline -opc)[2..-1])"
end
