function error_and_die() {
  echo -e "${binary}: $(basename ${0}): \033[0;31m[ERROR] ${1}\033[0;39m" >&2
  exit 1
}

function info() {
  echo -e "\033[0;32m[INFO] ${1}\033[0;39m"
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
_myARCH()  { echo -n $(uname -m | sed 's/x86_64/amd64/g'); }
_myMARCH() { echo -n $(uname -m); }
_myOSCap() { echo -n $(uname -s | sed 's/mingw64_nt.*/Windows/' ); }
_isOSX()   { case $(_myOS) in darwin) echo osx ;; *) _myOS ;; esac; }
_isMac()   { case $(_myOS) in darwin) echo mac;; *) echo $(_myOS);; esac; }
_isMacOS() { case $(_myOS) in darwin) echo macOS;; *) echo $(_myOS);; esac; }