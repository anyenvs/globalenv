#!/usr/bin/env bats

load test_helper

@test "without args shows summary of common commands" {
  run globalenv-help
  assert_success
  assert_line "Usage: globalenv <command> [<args>]"
  assert_line "Some useful globalenv commands are:"
}

@test "invalid command" {
  run globalenv-help hello
  assert_failure "globalenv: no such command \`hello'"
}

@test "shows help for a specific command" {
  mkdir -p "${GLOBALENV_TEST_DIR}/bin"
  cat > "${GLOBALENV_TEST_DIR}/bin/globalenv-hello" <<SH
#!shebang
# Usage: globalenv hello <world>
# Summary: Says "hello" to you, from globalenv
# This command is useful for saying hello.
echo hello
SH

  run globalenv-help hello
  assert_success
  assert_output <<SH
Usage: globalenv hello <world>

This command is useful for saying hello.
SH
}

@test "replaces missing extended help with summary text" {
  mkdir -p "${GLOBALENV_TEST_DIR}/bin"
  cat > "${GLOBALENV_TEST_DIR}/bin/globalenv-hello" <<SH
#!shebang
# Usage: globalenv hello <world>
# Summary: Says "hello" to you, from globalenv
echo hello
SH

  run globalenv-help hello
  assert_success
  assert_output <<SH
Usage: globalenv hello <world>

Says "hello" to you, from globalenv
SH
}

@test "extracts only usage" {
  mkdir -p "${GLOBALENV_TEST_DIR}/bin"
  cat > "${GLOBALENV_TEST_DIR}/bin/globalenv-hello" <<SH
#!shebang
# Usage: globalenv hello <world>
# Summary: Says "hello" to you, from globalenv
# This extended help won't be shown.
echo hello
SH

  run globalenv-help --usage hello
  assert_success "Usage: globalenv hello <world>"
}

@test "multiline usage section" {
  mkdir -p "${GLOBALENV_TEST_DIR}/bin"
  cat > "${GLOBALENV_TEST_DIR}/bin/globalenv-hello" <<SH
#!shebang
# Usage: globalenv hello <world>
#        globalenv hi [everybody]
#        globalenv hola --translate
# Summary: Says "hello" to you, from globalenv
# Help text.
echo hello
SH

  run globalenv-help hello
  assert_success
  assert_output <<SH
Usage: globalenv hello <world>
       globalenv hi [everybody]
       globalenv hola --translate

Help text.
SH
}

@test "multiline extended help section" {
  mkdir -p "${GLOBALENV_TEST_DIR}/bin"
  cat > "${GLOBALENV_TEST_DIR}/bin/globalenv-hello" <<SH
#!shebang
# Usage: globalenv hello <world>
# Summary: Says "hello" to you, from globalenv
# This is extended help text.
# It can contain multiple lines.
#
# And paragraphs.

echo hello
SH

  run globalenv-help hello
  assert_success
  assert_output <<SH
Usage: globalenv hello <world>

This is extended help text.
It can contain multiple lines.

And paragraphs.
SH
}
