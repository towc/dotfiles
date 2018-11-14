echo $(setxkbmap -query | grep layout | cut -d: -f2)
