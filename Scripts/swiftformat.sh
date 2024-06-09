#!/bin/bash

# Parameters
script_dir="$(
    cd -- "$(dirname "$0")" >/dev/null 2>&1
    pwd -P
)"
SOURCES_PATH=$1

# Setup
if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

# Only run if fastlane is not detected
if [ -z "$FASTLANE_LANE_NAME" ]; then
    mise exec swiftformat -- swiftformat --lint --lenient $SOURCES_PATH --config $script_dir/../.swiftformat
fi