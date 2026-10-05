#!/bin/bash
# Builds the Odin js_wasm32 version and pushes it to itch.io as the web channel.
# (The old Defold version and its deploy script were removed; they are in git history up to commit 6c5262a.)
set -e
cd "$(dirname "$0")"

./odin/build.sh
butler push odin/out thegrumpygamedev/how-am-i-still-waiting-for-the-bus:web
