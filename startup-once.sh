thyme-start &
redshift &
xautolock \
  -time 5 \
  -corners -000 \
  -notify 60 \
  -notifier "notify-send --urgency=\"critical\" --expire-time=30000 \"i3lock\" \"locking in 1 minute\"" \
  -locker /home/user/.i3/i3lock-multimonitor/lock &
