#!/bin/bash
# Builds the Odin js_wasm32 version and pushes it to itch.io as the web channel.
# (The old Defold deploy script is archived in archive/shippit_defold.sh.)
set -e
cd "$(dirname "$0")"

./odin/build.sh
butler push odin/out thegrumpygamedev/how-am-i-still-waiting-for-the-bus:web
