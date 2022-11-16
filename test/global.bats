#!/usr/bin/env bats

load test_helper

@test "default" {
  run globalenv-global
  assert_success
  assert_output "system"
}

@test "read GLOBALENV_ROOT/version" {
  mkdir -p "$GLOBALENV_ROOT"
  echo "1.2.3" > "$GLOBALENV_ROOT/version"
  run globalenv-global
  assert_success
  assert_output "1.2.3"
}

@test "set GLOBALENV_ROOT/version" {
  mkdir -p "$GLOBALENV_ROOT/versions/1.2.3/bin"
  run globalenv-global "1.2.3"
  assert_success
  run globalenv-global
  assert_success "1.2.3"
}

@test "fail setting invalid GLOBALENV_ROOT/version" {
  mkdir -p "$GLOBALENV_ROOT"
  run globalenv-global "1.2.3"
  assert_failure "GLOBALENV: version \`1.2.3' is not installed"
}
