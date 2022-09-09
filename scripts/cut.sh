#!/bin/bash

# Utilities
# Modified from https://gitlab.com/bertrand-benoit/scripts-common/-/blob/master/utilities.sh#L338
# usage: checkBin <binary name/path>
declare -r BSC_ERROR_CHECK_BIN=107
function checkBin() {
  local _binary="$1" _full_path

  # Checks if the binary is available.
  _full_path=$( command -v "$_binary" )
  commandStatus=$?
  
  [ -x "$_full_path" ] && return 0

  # Otherwise, simple returns an error code.
  return $BSC_ERROR_CHECK_BIN
}

# Checks
checkBin ffmpeg || (echo "ffmpeg was not found!" && exit 1)
checkBin sed    || (echo "sed was not found!"    && exit 1)
checkBin head   || (echo "head was not found!"   && exit 1)
checkBin tail   || (echo "tail was not found!"   && exit 1)
checkBin qalc   || (echo "qalc was not found!"   && exit 1)

# Main
FILE="$1"
TIME=$(ffmpeg -i "$FILE" -map 0:a:0 -af silencedetect=n=-50dB:d=0.5,ametadata=mode=print:file=/dev/stdout -f null - 2>/dev/null | rg 'silence_(start|end)' | sed -n -e '2p;$p')

TIMELIST=$(echo "$TIME" | sed -n -e 's/.*=//g;p')
FROM=$(echo "$TIMELIST" | head -n 1)
FROM_SEC=$(qalc -t "$FROM - 2")
TO=$(echo "$TIMELIST" | tail -n 1)
TO_SEC=$(qalc -t "$TO + 2")

# Results
FILE_RESULT="${FILE%.*}"
ffmpeg -hide_banner -ss "$FROM_SEC" -to "$TO_SEC" -i "$FILE" -c copy "$FILE_RESULT.mkv"
echo "{\"from\":$FROM_SEC,\"to\":$TO_SEC}" > "$FILE_RESULT.json"