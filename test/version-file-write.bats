#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$GLOBALENV_TEST_DIR"
  cd "$GLOBALENV_TEST_DIR"
}

@test "invocation without 2 arguments prints usage" {
  run globalenv-version-file-write
  assert_failure "Usage: globalenv version-file-write <file> <version>"
  run globalenv-version-file-write "one" ""
  assert_failure
}

@test "setting nonexistent version fails" {
  assert [ ! -e ".helm-version" ]
  run globalenv-version-file-write ".helm-version" "1.11.3"
  assert_failure "globalenv: version \`1.11.3' is not installed"
  assert [ ! -e ".helm-version" ]
}

@test "writes value to arbitrary file" {
  mkdir -p "${GLOBALENV_ROOT}/versions/1.10.8/bin"
  assert [ ! -e "my-version" ]
  run globalenv-version-file-write "${PWD}/my-version" "1.10.8"
  assert_success ""
  assert [ "$(cat my-version)" = "1.10.8" ]
}
