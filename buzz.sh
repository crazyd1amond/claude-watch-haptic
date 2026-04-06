#!/usr/bin/env bash
# buzz.sh — Apple Watch haptic via iCloud Reminder
# Called by Claude Code hooks: Stop, Notification

set -euo pipefail

DELETE_AFTER=15

osascript <<'APPLESCRIPT'
tell application "Reminders"
  tell list "提醒" of account "iCloud"
    make new reminder with properties {name:"●", remind me date:((current date) + 8), completed:false}
  end tell
end tell
APPLESCRIPT

(
  sleep "$DELETE_AFTER"
  osascript <<'APPLESCRIPT'
  tell application "Reminders"
    tell list "提醒" of account "iCloud"
      set rs to (reminders whose name is "●" and completed is false)
      repeat with r in rs
        set completed of r to true
        delete r
      end repeat
    end tell
  end tell
APPLESCRIPT
) &

exit 0
