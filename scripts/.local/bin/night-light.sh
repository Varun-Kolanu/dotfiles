#!/usr/bin/env bash
set -euo pipefail

cmd="$1"; shift || true

is_running() {
    pgrep -x hyprsunset >/dev/null 2>&1
}

case "${cmd:-toggle}" in
    toggle)
        if is_running; then
            pkill hyprsunset
            notify-send "Night filter" "hyprsunset stopped"
        else
            hyprsunset >/dev/null 2>&1 &
            notify-send "Night filter" "hyprsunset started"
        fi
    ;;
    on)
        if ! is_running; then
            hyprsunset >/dev/null 2>&1 &
            notify-send "Night filter" "hyprsunset started"
        fi
    ;;
    off)
        pkill hyprsunset || true
        notify-send "Night filter" "hyprsunset stopped"
    ;;
    *)
        echo "Usage: $0 [toggle|on|off]" >&2
        exit 2
    ;;
esac
