#!/usr/bin/env bats

load test_helper

@test "blank invocation" {
  run GLOBALENV
  assert_failure
  assert_line 0 "$(globalenv---version)"
}

@test "invalid command" {
  run GLOBALENV does-not-exist
  assert_failure
  assert_output "GLOBALENV: no such command \`does-not-exist'"
}

@test "default GLOBALENV_ROOT" {
  GLOBALENV_ROOT="" HOME=$HOME run GLOBALENV root
  assert_success
  assert_output "$HOME/.globalenv"
}

@test "inherited GLOBALENV_ROOT" {
  GLOBALENV_ROOT=/opt/GLOBALENV run GLOBALENV root
  assert_success
  assert_output "/opt/GLOBALENV"
}
