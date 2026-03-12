#!/bin/sh
# /root/carp_control.sh

TAG="CARP_MONITOR"
CURRENT=$(sysctl -n net.inet.carp.demotion)

if [ "$1" = "down" ]; then
    # Check if we are below 240
    if [ "$CURRENT" -lt 240 ]; then
        sysctl net.inet.carp.demotion=$((240-$CURRENT))
        logger -t $TAG "WAN failure detected. Increased CARP demotion to 240 (S>
    fi
elif [ "$1" = "up" ]; then
    # Check if we are demoted before trying to fix it
    if [ "$CURRENT" -gt 0 ]; then
        sysctl net.inet.carp.demotion=-$CURRENT
        logger -t $TAG "WAN restored. Reset CARP demotion to 0 (Reclaiming Mast>
    fi
fi