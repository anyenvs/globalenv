#!/usr/bin/env bats

load test_helper

create_executable() {
  name="${1?}"
  shift 1
  bin="${GLOBALENV_ROOT}/versions/${GLOBALENV_VERSION}/bin"
  mkdir -p "$bin"
  { if [ $# -eq 0 ]; then cat -
    else echo "$@"
    fi
  } | sed -Ee '1s/^ +//' > "${bin}/$name"
  chmod +x "${bin}/$name"
}

@test "fails with invalid version" {
  export GLOBALENV_VERSION="0.0.0"
  run GLOBALENV-exec version
  assert_failure "GLOBALENV: version \`0.0.0' is not installed"
}

@test "fails with invalid version set from file" {
  mkdir -p "$GLOBALENV_TEST_DIR"
  cd "$GLOBALENV_TEST_DIR"
  echo 0.0.1 > .helm-version
  run GLOBALENV-exec rspec
  assert_failure "GLOBALENV: version \`0.0.1' is not installed (set by $PWD/.helm-version)"
}
