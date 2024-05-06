SOURCES_PATH=$1

echo "${SRCROOT}"
echo "${SOURCES_PATH}"

TAGS="TODO:|FIXME:"
ERRORTAG="ERROR:"

# Only run if fastlane is not detected (local builds)
if [ -z "$FASTLANE_LANE_NAME" ]; then
    find "${SOURCES_PATH}" \( -name "*.h" -or -name "*.m" -or -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$|($ERRORTAG).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/" | perl -p -e "s/($ERRORTAG)/ error: \$1/"
fi