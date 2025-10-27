#!/bin/bash
# ~/start-walker.sh

# Kill any existing Walker instances
pkill walker 2>/dev/null

# Ensure proper session environment
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

# Launch Walker
exec /usr/bin/walker --gapplication-service
