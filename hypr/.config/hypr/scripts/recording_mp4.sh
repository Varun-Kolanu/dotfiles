#!/bin/bash

# Output paths
outdir=~/Videos
outfile="$outdir/rec-$(date +'%Y-%m-%d-%H-%M-%S').mp4"

# Check if wf-recorder is already running
if pgrep -x "wf-recorder" > /dev/null; then
    # Stop recording
    pkill -INT wf-recorder
    notify-send "🎬 Recording stopped" "Saved as MP4: $outfile"
else
    # Start new recording with region selection
    notify-send "🎥 Recording started" "Select an area..."
    wf-recorder -g "$(slurp)" -f "$outfile" &
fi
