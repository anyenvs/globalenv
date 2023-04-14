##
## Helper functions
##
#version=${version:-${1//*-/}}
#version=${version#[[:alpha:]]*-}
version=$([[ ${1} == [[:digit:]]* ]] && echo ${1#*v} || echo ${1##*[[:alpha:]]-})
version=${version#*v}
binary=${binary[@]}
binshort=${binary//env*/}

function _log() { echo -e "\033[0;32m[INFO] ${1}\033[0;39m"; }

[ -n "${ENV_DEBUG}" ] && echo binary=${binary[@]} binshort=${binary//env*/} version=${version#*v}
[ -n "${ENV_DEBUG}" ] && _log "ARGS=$@"
[ -n "${ENV_DEBUG}" ] && { export PS4='+ [${BASH_SOURCE##*/}:${LINENO}] ' ; set -x; }

function error_and_die() {
  echo -e "${binary}: $(basename ${0}): \033[0;31m[ERROR] ${1}\033[0;39m" >&2
  exit 1
}

function realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

## Common OS validations
_RELEASE() { . /etc/os-release ; case $ID in debian) echo "${ID^}_${VERSION_ID}" ;; ubuntu) echo "x${ID^}_${VERSION_ID}" ;; esac; set +x; }
_myOS()    { echo -n $(uname -s | tr '[:upper:]' '[:lower:]:'|sed 's/mingw64_nt.*/windows/' ); }
_myARCH()  { echo -n $(uname -m | sed 's/x86_64/amd64/g; s/armv7.*/armv7/g'); }
_myMARCH() { echo -n $(uname -m); }
_myOSCap() { echo -n $(uname -s | sed 's/mingw64_nt.*/Windows/' ); }
_isOSX()   { case $(_myOS) in darwin) echo osx ;; *) _myOS ;; esac; }
_isMac()   { case $(_myOS) in darwin) echo mac;; *) echo $(_myOS);; esac; }
_isMacOS() { case $(_myOS) in darwin) echo macOS;; *) echo $(_myOS);; esac; }
