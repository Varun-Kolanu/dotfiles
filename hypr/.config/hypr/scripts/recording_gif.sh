#!/bin/bash

outdir="$HOME/Videos"
runtime="${XDG_RUNTIME_DIR:-/tmp}"
state_dir="$runtime/wf-recorder-gif-state"

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
            # Stop the entire recording session
            kill -INT -- "-$pid" 2>/dev/null

            # Wait until the recording process has completely exited
            for _ in {1..50}; do
                if ! kill -0 "$pid" 2>/dev/null; then
                    break
                fi
                sleep 0.1
            done

            # Make sure the MP4 actually exists
            if [[ ! -f "$outfile" ]]; then
                rm -rf "$state_dir"

                notify-send "❌ Recording failed" \
                    "MP4 file was not created."
                exit 1
            fi

            gifout="${outfile%.mp4}.gif"

            # Convert the exact recording we just made
            if ffmpeg -y \
                -i "$outfile" \
                -vf "fps=15,scale=640:-1:flags=lanczos" \
                "$gifout"
            then
                notify-send "🎬 Recording stopped" \
                    "Saved as GIF: $(basename "$gifout")"
            else
                notify-send "❌ GIF conversion failed" \
                    "MP4 saved as: $(basename "$outfile")"
            fi

        else
            # Region selection is still active
            kill -TERM -- "-$pid" 2>/dev/null

            notify-send "❌ Recording cancelled" \
                "Region selection was cancelled."
        fi

    else
        # Remove stale state
        rm -rf "$state_dir"
    fi

    exit 0
fi


# --------------------------------------------------
# START NEW SESSION
# --------------------------------------------------

# Prevent two instances from starting simultaneously
mkdir "$state_dir" 2>/dev/null || exit 0

outfile="$outdir/rec-$(date +'%Y%m%d-%H%M%S').mp4"

# Set initial state before starting the child
echo "selecting" > "$state_dir/status"
echo "$outfile" > "$state_dir/outfile"


# Start the whole session in its own process group
setsid bash -c '
    state_dir="$1"
    outfile="$2"

    cleanup() {
        rm -rf "$state_dir"
    }

    trap cleanup EXIT

    # -----------------------------
    # Region selection
    # -----------------------------

    region=$(slurp 2>/dev/null)

    # User cancelled slurp
    if [[ $? -ne 0 || -z "$region" ]]; then
        notify-send "❌ Recording cancelled" \
            "No region was selected."
        exit 0
    fi

    # -----------------------------
    # Actual recording
    # -----------------------------

    echo "recording" > "$state_dir/status"

    notify-send "🎥 Recording started" \
        "Recording selected area..."

    wf-recorder -g "$region" -f "$outfile"
' _ "$state_dir" "$outfile" &

pid=$!

echo "$pid" > "$state_dir/pid"