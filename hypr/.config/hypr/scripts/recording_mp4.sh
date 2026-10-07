#!/bin/bash

outdir="$HOME/Videos"
runtime="${XDG_RUNTIME_DIR:-/tmp}"
state_dir="$runtime/wf-recorder-state"

mkdir -p "$outdir"

# --------------------------------------------------
# STOP / CANCEL EXISTING SESSION
# --------------------------------------------------

if [[ -f "$state_dir/pid" ]]; then
    pid=$(<"$state_dir/pid")
    outfile=$(<"$state_dir/outfile")
    status=$(<"$state_dir/status")

    if kill -0 "$pid" 2>/dev/null; then

        if [[ "$status" == "recording" ]]; then
            # Kill the whole session: bash + wf-recorder
            kill -INT -- "-$pid" 2>/dev/null

            # Give wf-recorder a moment to finish writing the file
            for _ in {1..20}; do
                if ! kill -0 "$pid" 2>/dev/null; then
                    break
                fi
                sleep 0.1
            done

            notify-send "🎬 Recording stopped" \
                "Saved as MP4: $(basename "$outfile")"

        else
            # Region selection is still active
            kill -TERM -- "-$pid" 2>/dev/null

            notify-send "❌ Recording cancelled" \
                "Region selection was cancelled."
        fi

    else
        # Stale state
        rm -rf "$state_dir"
    fi

    exit 0
fi


# --------------------------------------------------
# START NEW SESSION
# --------------------------------------------------

mkdir "$state_dir" 2>/dev/null || exit 0

outfile="$outdir/rec-$(date +'%Y-%m-%d-%H-%M-%S').mp4"

# Start a separate process group so we can kill both
# slurp and wf-recorder together.
setsid bash -c '
    state_dir="$1"
    outfile="$2"

    cleanup() {
        rm -rf "$state_dir"
    }

    trap cleanup EXIT

    # We are currently selecting a region
    echo "selecting" > "$state_dir/status"

    region=$(slurp 2>/dev/null)

    # User cancelled slurp (Esc, etc.)
    if [[ $? -ne 0 || -z "$region" ]]; then
        notify-send "❌ Recording cancelled" \
            "No region was selected."
        exit 0
    fi

    # Now wf-recorder is actually about to start
    echo "recording" > "$state_dir/status"

    notify-send "🎥 Recording started" \
        "Recording selected area..."

    wf-recorder -g "$region" -f "$outfile"

' _ "$state_dir" "$outfile" &

pid=$!

# Store session information
echo "$pid" > "$state_dir/pid"
echo "$outfile" > "$state_dir/outfile"

# Initial state; the background process will change this
# to "recording" after slurp finishes.
echo "selecting" > "$state_dir/status"