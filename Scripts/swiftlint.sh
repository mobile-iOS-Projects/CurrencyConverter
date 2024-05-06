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

# Run SwiftLint for mulitple input files
run_swiftlint_batch() {
    echo "swiftlint --use-script-input-files --config ./../.swiftformat --quiet"
    mise exec swiftlint -- swiftlint --use-script-input-files --config $script_dir/../.swiftlint.yml --quiet
}

# Only run if fastlane is not detected -> on CI, swiftlint is triggered by fastlane
if [ -z "$FASTLANE_LANE_NAME" ]; then
    # Obtain full path to the file
    FULL_PATH=$"$(git rev-parse --show-toplevel)"

    # Loop over unstaged files
    count=0
    while IFS= read -r file_path; do
        # Only add file if its path starts with SOURCE_PATH
        FULL_FILE_PATH=$"${FULL_PATH}/${file_path}"
        if [[ "${FULL_FILE_PATH}" == $SOURCES_PATH* ]]; then
            export SCRIPT_INPUT_FILE_$count="$FULL_FILE_PATH"
            count=$((count + 1))
        fi
    done < <(git diff --name-only --diff-filter=d | grep ".swift$")

    # Loop over staged files
    while IFS= read -r file_path; do
        # Only add file if its path starts with SOURCE_PATH
        FULL_FILE_PATH=$"${FULL_PATH}/${file_path}"
        if [[ "${FULL_FILE_PATH}" == $SOURCES_PATH* ]]; then
            export SCRIPT_INPUT_FILE_$count="$FULL_FILE_PATH"
            count=$((count + 1))
        fi
    done < <(git diff --name-only --cached --diff-filter=d | grep ".swift$")

    export SCRIPT_INPUT_FILE_COUNT=$count
    if [ "$count" -eq 0 ]; then
        echo "No files to lint!"
        exit 0
    fi
    echo "Found $count lintable files! Linting now.."
    run_swiftlint_batch
fi
