#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$GLOBALENV_TEST_DIR"
  cd "$GLOBALENV_TEST_DIR"
}

create_file() {
  mkdir -p "$(dirname "$1")"
  echo "system" > "$1"
}

@test "detects global 'version' file" {
  create_file "${GLOBALENV_ROOT}/version"
  run globalenv-version-file
  assert_success "${GLOBALENV_ROOT}/version"
}

@test "prints global file if no version files exist" {
  assert [ ! -e "${GLOBALENV_ROOT}/version" ]
  assert [ ! -e ".helm-version" ]
  run globalenv-version-file
  assert_success "${GLOBALENV_ROOT}/version"
}

@test "in current directory" {
  create_file ".helm-version"
  run globalenv-version-file
  assert_success "${GLOBALENV_TEST_DIR}/.helm-version"
}

@test "in parent directory" {
  create_file ".helm-version"
  mkdir -p project
  cd project
  run globalenv-version-file
  assert_success "${GLOBALENV_TEST_DIR}/.helm-version"
}

@test "topmost file has precedence" {
  create_file ".helm-version"
  create_file "project/.helm-version"
  cd project
  run globalenv-version-file
  assert_success "${GLOBALENV_TEST_DIR}/project/.helm-version"
}

@test "GLOBALENV_DIR has precedence over PWD" {
  create_file "widget/.helm-version"
  create_file "project/.helm-version"
  cd project
  GLOBALENV_DIR="${GLOBALENV_TEST_DIR}/widget" run globalenv-version-file
  assert_success "${GLOBALENV_TEST_DIR}/widget/.helm-version"
}

@test "PWD is searched if GLOBALENV_DIR yields no results" {
  mkdir -p "widget/blank"
  create_file "project/.helm-version"
  cd project
  GLOBALENV_DIR="${GLOBALENV_TEST_DIR}/widget/blank" run globalenv-version-file
  assert_success "${GLOBALENV_TEST_DIR}/project/.helm-version"
}

@test "finds version file in target directory" {
  create_file "project/.helm-version"
  run globalenv-version-file "${PWD}/project"
  assert_success "${GLOBALENV_TEST_DIR}/project/.helm-version"
}

@test "fails when no version file in target directory" {
  run globalenv-version-file "$PWD"
  assert_failure ""
}
