#!/bin/sh
exec nix develop "$(dirname "$0")/.." --command tinymist "$@"
