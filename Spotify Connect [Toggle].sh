#!/bin/sh

if pgrep -f "playbgm.sh" >/dev/null; then
	killall -q "playbgm.sh" "mp3play"
fi

if pgrep -f "muplay" >/dev/null; then
	killall -q "muplay"
	rm "$SND_PIPE"
fi

. /opt/muos/script/var/func.sh
. /opt/muos/script/var/device/device.sh

# Define paths
LIBRESPOT_BIN="/mnt/mmc/MUOS/application/.librespot/librespot"
CACHE_DIR="/tmp/spotify_cache"
DEVICE_ID_FILE="/mnt/mmc/MUOS/application/.librespot/device_id.txt"

# Generate a random device ID on the first run
if [ ! -f "$DEVICE_ID_FILE" ]; then
    DEVICE_ID="$DC_DEV_NAME [$(shuf -i 100000-999999 -n 1)]"
    echo "$DEVICE_ID" > "$DEVICE_ID_FILE"
else
    DEVICE_ID=$(cat "$DEVICE_ID_FILE")
fi

# Check if librespot is already running
LIBRESPOT_PID=$(pgrep -f "$LIBRESPOT_BIN")

if [ -n "$LIBRESPOT_PID" ]; then
    echo "librespot is running with PID $LIBRESPOT_PID. Stopping it..."
    kill "$LIBRESPOT_PID"
else
    echo "librespot is not running. Starting it..."
    nice --20 "$LIBRESPOT_BIN" --name "$DEVICE_ID" --cache "$CACHE_DIR" &
fi

