#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$GLOBALENV_TEST_DIR"
  cd "$GLOBALENV_TEST_DIR"
}

@test "no version selected" {
  assert [ ! -d "${GLOBALENV_ROOT}/versions" ]
  run globalenv-version-name
  assert_success "system"
}

@test "system version is not checked for existance" {
  GLOBALENV_VERSION=system run globalenv-version-name
  assert_success "system"
}

@test "GLOBALENV_VERSION has precedence over local" {
  create_version "1.10.8"
  create_version "1.11.3"

  cat > ".helm-version" <<<"1.10.8"
  run globalenv-version-name
  assert_success "1.10.8"

  GLOBALENV_VERSION=1.11.3 run globalenv-version-name
  assert_success "1.11.3"
}

@test "local file has precedence over global" {
  create_version "1.10.8"
  create_version "1.11.3"

  cat > "${GLOBALENV_ROOT}/version" <<<"1.10.8"
  run globalenv-version-name
  assert_success "1.10.8"

  cat > ".helm-version" <<<"1.11.3"
  run globalenv-version-name
  assert_success "1.11.3"
}

@test "missing version" {
  GLOBALENV_VERSION=1.2 run globalenv-version-name
  assert_failure "globalenv: version \`1.2' is not installed (set by GLOBALENV_VERSION environment variable)"
}
