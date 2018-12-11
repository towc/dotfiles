#!/usr/bin/zsh
xautolock -corners "----" \
  -time 5 \
  -notify 60 \
  -notifier "notify-send 'xautolock' 'locking screen in 1 minute'" \
  -locker '~/.bin/lock-screen' &

dunst &
