# shellcheck shell=bash
#
# Helpers shared by script/update-formula and script/sync-formula.

# Bounded requests, so a stalled connection cannot hang a scheduled run.
CURL_OPTS=(--connect-timeout 10 --max-time 60)

# What counts as a version anywhere in this repo: X.Y.Z with an optional
# pre-release or build suffix. Shared so both scripts agree.
VERSION_PATTERN='^[0-9]+\.[0-9]+\.[0-9]+([-+][0-9A-Za-z.-]+)?$'

die() {
  echo "$*" >&2
  exit 1
}

# Resolves usage() from the sourcing script, so each keeps its own text.
die_with_usage() {
  echo "$*" >&2
  usage
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}
