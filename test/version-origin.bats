#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$GLOBALENV_TEST_DIR"
  cd "$GLOBALENV_TEST_DIR"
}

@test "reports global file even if it doesn't exist" {
  assert [ ! -e "${GLOBALENV_ROOT}/version" ]
  run globalenv-version-origin
  assert_success "${GLOBALENV_ROOT}/version"
}

@test "detects global file" {
  mkdir -p "$GLOBALENV_ROOT"
  touch "${GLOBALENV_ROOT}/version"
  run globalenv-version-origin
  assert_success "${GLOBALENV_ROOT}/version"
}

@test "detects GLOBALENV_VERSION" {
  GLOBALENV_VERSION=1 run globalenv-version-origin
  assert_success "GLOBALENV_VERSION environment variable"
}

@test "detects local file" {
  echo "system" > .helm-version
  run globalenv-version-origin
  assert_success "${PWD}/.helm-version"
}

@test "doesn't inherit GLOBALENV_VERSION_ORIGIN from environment" {
  GLOBALENV_VERSION_ORIGIN=ignored run globalenv-version-origin
  assert_success "${GLOBALENV_ROOT}/version"
}
