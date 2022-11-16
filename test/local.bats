#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "${GLOBALENV_TEST_DIR}/myproject"
  cd "${GLOBALENV_TEST_DIR}/myproject"
}

@test "no version" {
  assert [ ! -e "${PWD}/.helm-version" ]
  run globalenv-local
  assert_failure "globalenv: no local version configured for this directory"
}

@test "local version" {
  echo "1.2.3" > .helm-version
  run globalenv-local
  assert_success "1.2.3"
}

@test "discovers version file in parent directory" {
  echo "1.2.3" > .helm-version
  mkdir -p "subdir" && cd "subdir"
  run globalenv-local
  assert_success "1.2.3"
}

@test "ignores GLOBALENV_DIR" {
  echo "1.2.3" > .helm-version
  mkdir -p "$HOME"
  echo "2.0-home" > "${HOME}/.helm-version"
  GLOBALENV_DIR="$HOME" run globalenv-local
  assert_success "1.2.3"
}

@test "sets local version" {
  mkdir -p "${GLOBALENV_ROOT}/versions/1.2.3/bin"
  run globalenv-local 1.2.3
  assert_success ""
  assert [ "$(cat .helm-version)" = "1.2.3" ]
}

@test "changes local version" {
  echo "1.0-pre" > .helm-version
  mkdir -p "${GLOBALENV_ROOT}/versions/1.2.3/bin"
  run globalenv-local
  assert_success "1.0-pre"
  run globalenv-local 1.2.3
  assert_success ""
  assert [ "$(cat .helm-version)" = "1.2.3" ]
}

@test "unsets local version" {
  touch .helm-version
  run globalenv-local --unset
  assert_success ""
  assert [ ! -e .helm-version ]
}
