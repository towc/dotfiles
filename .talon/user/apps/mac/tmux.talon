app: Tmux
app: Code
app: /.*/
and title: /^((?!vim).)*tmux/i

-
tex:
  # tmux
  key(ctrl-b)

tex horse:
  key(ctrl-b %)
tex vert:
  key(ctrl-b ")

ghost (right | east):
  key(ctrl-l)
ghost (up | north):
  key(ctrl-k)
ghost (down | south):
  key(ctrl-j)
ghost (left | west):
  key(ctrl-h)
