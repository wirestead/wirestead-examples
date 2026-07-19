#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

RUN_FETCHCONTENT=1
RUN_VCPKG=1
RUN_INSTALLED=0
INSTALLED_PREFIX="${WIRESTEAD_INSTALL_PREFIX:-${UNILINK_INSTALL_PREFIX:-}}"

usage() {
  cat <<'EOF'
Usage: scripts/verify.sh [options]

Options:
  --skip-fetchcontent       Skip the FetchContent preset build.
  --skip-vcpkg              Skip the vcpkg preset build.
  --installed-prefix PATH   Run the installed-package preset with PATH.
  --help, -h                Show this help message.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --skip-fetchcontent)
      RUN_FETCHCONTENT=0
      shift
      ;;
    --skip-vcpkg)
      RUN_VCPKG=0
      shift
      ;;
    --installed-prefix)
      if [[ $# -lt 2 ]]; then
        echo "--installed-prefix requires a path" >&2
        exit 1
      fi
      INSTALLED_PREFIX="$2"
      RUN_INSTALLED=1
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

section() {
  printf '\n===== %s =====\n' "$*"
}

run_preset() {
  local preset="$1"
  section "Configuring ${preset}"
  cmake --preset "$preset"
  section "Building ${preset}"
  cmake --build --preset "$preset" --parallel
}

section "Checking whitespace"
git diff --check

if [[ "$RUN_FETCHCONTENT" -eq 1 ]]; then
  run_preset fetchcontent
fi

if [[ "$RUN_VCPKG" -eq 1 ]]; then
  if [[ -z "${VCPKG_ROOT:-}" ]]; then
    echo "VCPKG_ROOT is not set. Set VCPKG_ROOT or pass --skip-vcpkg." >&2
    exit 1
  elif [[ ! -f "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" ]]; then
    echo "VCPKG_ROOT does not contain scripts/buildsystems/vcpkg.cmake." >&2
    echo "Set VCPKG_ROOT to a bootstrapped vcpkg checkout or pass --skip-vcpkg." >&2
    exit 1
  else
    run_preset vcpkg
  fi
fi

if [[ "$RUN_INSTALLED" -eq 1 ]]; then
  if [[ -z "$INSTALLED_PREFIX" ]]; then
    echo "Installed prefix is empty" >&2
    exit 1
  fi
  section "Configuring installed"
  WIRESTEAD_INSTALL_PREFIX="$INSTALLED_PREFIX" cmake --preset installed
  section "Building installed"
  cmake --build --preset installed --parallel
fi

section "Verification complete"
