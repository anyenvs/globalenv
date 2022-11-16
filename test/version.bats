#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$GLOBALENV_TEST_DIR"
  cd "$GLOBALENV_TEST_DIR"
}

@test "no version selected" {
  assert [ ! -d "${GLOBALENV_ROOT}/versions" ]
  run globalenv-version
  assert_success "system (set by ${GLOBALENV_ROOT}/version)"
}

@test "set by GLOBALENV_VERSION" {
  create_version "1.11.3"
  GLOBALENV_VERSION=1.11.3 run globalenv-version
  assert_success "1.11.3 (set by GLOBALENV_VERSION environment variable)"
}

@test "set by local file" {
  create_version "1.11.3"
  cat > ".helm-version" <<<"1.11.3"
  run globalenv-version
  assert_success "1.11.3 (set by ${PWD}/.helm-version)"
}

@test "set by global file" {
  create_version "1.11.3"
  cat > "${GLOBALENV_ROOT}/version" <<<"1.11.3"
  run globalenv-version
  assert_success "1.11.3 (set by ${GLOBALENV_ROOT}/version)"
}
