# /conf/tailscale_watchdog.sh
#!/bin/sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

# This ensures that when this script is stopped (SIGTERM/EXIT),
# it kills all background jobs (like the process_events loop) immediately.
cleanup() {
    # Kill all child processes of this script
    pkill -P $$
    exit 0
}
trap cleanup SIGINT SIGTERM EXIT

# --- Configuration ---
STATIC_ROUTES="10.0.0.0/16"
# Reduced to 2s based on your logs (bursts take ~1.1s)
DEBOUNCE_DELAY=2
TRIGGER_FILE="/tmp/tailscale_routes_dirty"

# --- Function: The Actual Sync Logic ---
sync_tailscale() {
    # 1. Normalize Helper
    normalize_list() {
        echo "$1" | tr ',' '\n' | grep -v "^$" | sort -u | paste -sd "," -
    }

    # 2. Fetch OSPF Routes
    OSPF_ROUTES=$(vtysh -c "show ip route ospf" | grep "O>\*" | grep "wg" | awk '{print $2}' | grep '/16' | tr '\n' ',' | sed 's/,$//')

    # 3. Construct Target List
    RAW_TARGET="$STATIC_ROUTES,$OSPF_ROUTES"
    TARGET_ADVERTISE_LIST=$(normalize_list "$RAW_TARGET")

    # 4. Get Current Tailscale Config
    CURRENT_RAW=$(tailscale debug prefs | jq -r '.AdvertiseRoutes | join(",")')
    CURRENT_ADVERTISE_LIST=$(normalize_list "$CURRENT_RAW")

    # 5. Compare
    if [ "$TARGET_ADVERTISE_LIST" != "$CURRENT_ADVERTISE_LIST" ]; then
        logger "Tailscale Watchdog: CHANGE DETECTED."
        logger "Tailscale Watchdog: New Config: $TARGET_ADVERTISE_LIST"
        tailscale set --advertise-routes="$TARGET_ADVERTISE_LIST"
        logger "Tailscale Watchdog: Synced successfully."
    else
        logger "Tailscale Watchdog: Routes checked. ($TARGET_ADVERTISE_LIST) No changes needed."
    fi
 }


# --- Background Processor ---
# This loop handles the debounce and syncing.
# It runs independently of the route monitor stream.
process_events() {
    while true; do
        if [ -f "$TRIGGER_FILE" ]; then
            # Found a trigger! Wait for the 'debounce' period to let routes settle.
            sleep $DEBOUNCE_DELAY

            # Check if the file was touched AGAIN while we were sleeping (Sliding Window)
            # If the file is newer than when we started sleeping, we loop again to wait more.
            # Ideally we check timestamps, but simply removing the file *before* sync
            # handles the race condition safely enough for this use case.

            mv "$TRIGGER_FILE" "${TRIGGER_FILE}.processing"

            sync_tailscale

            rm -f "${TRIGGER_FILE}.processing"
        else
            # Sleep to save CPU when nothing is happening
            sleep 1
        fi
    done
}

start_listener() {
    route -n monitor | grep --line-buffered -e " route " -e "wg" | while read -r line ; do
        touch "$TRIGGER_FILE"
    done
}

# --- Main Execution ---
logger "Starting Tailscale Watchdog (Interruptible Mode)..."

# 1. Start the processor in background
process_events &

# 2. Start the listener in background
start_listener &
LISTENER_PID=$!

wait $LISTENER_PID