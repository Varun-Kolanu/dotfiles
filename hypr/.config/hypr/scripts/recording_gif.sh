#!/bin/bash

# Output paths
outdir=~/Videos
outfile="$outdir/rec-$(date +'%Y%m%d-%H%M%S').mp4"
gifout="${outfile%.mp4}.gif"

# Check if wf-recorder is already running
if pgrep -x "wf-recorder" > /dev/null; then
    # Stop recording
    pkill -INT wf-recorder

    # Wait to ensure the file is closed
    sleep 1

    # Convert last recorded file to GIF
    latest=$(ls -t "$outdir"/rec-*.mp4 | head -n1)
    ffmpeg -y -i "$latest" -vf "fps=15,scale=640:-1:flags=lanczos" "${latest%.mp4}.gif"

    notify-send "🎬 Recording stopped" "Saved as GIF: ${latest%.mp4}.gif"
else
    # Start new recording with region selection
    notify-send "🎥 Recording started" "Select an area..."
    wf-recorder -g "$(slurp)" -f "$outfile" &
fi
