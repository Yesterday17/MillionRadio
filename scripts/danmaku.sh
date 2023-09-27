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
checkBin ffmpeg   || (echo "ffmpeg was not found!"    && exit 1)
checkBin mkvmerge || (echo "mkvmerge was not found!"  && exit 1)
checkBin jq       || (echo "jq was not found!"        && exit 1)

FILE="$1"
FILENAME="${FILE%.*}"
FROM=$(cat "$FILENAME.json" | jq .from)
ffmpeg -itsoffset "-$FROM" -i "$FILENAME.ass" "$FILENAME_shifted.ass"
ffmpeg -threads 32 -i "$FILE" -vf "fps=60,ass=$FILENAME_shifted.ass:fontsdir=./fonts" -c:a copy -c:v h264_nvenc -pix_fmt yuv420p "$FILENAME-danmaku.mkv"
mkvmerge "$FILENAME-danmaku.mkv" -o "$FILENAME-弹幕版.mkv"
rm "$FILENAME-danmaku.mkv"
