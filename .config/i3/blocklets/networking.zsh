if [ $(hostname -I | wc -m) -gt 3 ]; then
  echo "$(hostname -I | cut -d" " -f1) at $(iwgetid | cut -d\" -f2)"
  echo ""
  echo "#55cc55"
else
  echo "no conn"
  echo ""
  echo "#ff5555"
fi
