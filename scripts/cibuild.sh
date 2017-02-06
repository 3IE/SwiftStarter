#!/bin/sh

SCRIPT_DIR=$(dirname "$0")
BOOTSTRAPIFNEEDED="$SCRIPT_DIR/bootstrap-if-needed.sh"

$BOOTSTRAPIFNEEDED
xcodebuild