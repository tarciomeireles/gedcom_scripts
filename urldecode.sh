#!/usr/bin/env bash
#
# urldecode - decodificando de urlencoded para texto legível

urldecode() {
  local encoded="${*//+/ }"
  printf '%b' "${encoded//%/\\x}"
}

urldecode "$@"