app: Vim
app: Code
app: /.*/
and title: /vim/i

-
delete [around] word:
    key(d)
    key(a)
    key(w)

change [inner] word:
    key(c)
    key(i)
    key(w)

change until:
    key(d)
    key(t)

delete until:
    key(d)
    key(t)

go until:
  key(t)

go find:
  key(f)

go back until:
  key(shift-t)

go back find:
  key(shift-f)

easy [motion] up:
    key(,)
    key(,)
    key(k)

easy [motion] down:
    key(,)
    key(,)
    key(j)

delete line:
    key(escape)
    key(d)
    key(d)

insert line up:
    key(m)
    key(z)
    key(shift-o)
    key(escape)
    key(`)
    key(z)

insert line down:
    key(m)
    key(z)
    key(o)
    key(escape)
    sleep(50ms)
    key(`)
    key(z)

insert last line:
  key(shift-o)

insert line:
  key(o)

go end:
  key(shift-g)

go start:
  key(g)
  key(g)

go match:
  key(%)

go back:
  key(ctrl-o)

save:
  key(ctrl-s)
quit:
  key(ctrl-q)

next:
  key(n)
previous:
  key(n)

search:
  key(/)

find file:
  insert("\\zx")

find text:
  insert("\\zv")

undo:
  key(escape)
  key(u)

append:
  key(a)

config the:
  # vim
  key(escape)
  insert("\\ve")

config new:
  key(escape)
  insert(":split ~/.talon/user/knausj_talon/apps/mac/.talon")
  key(left)
  key(left)
  key(left)
  key(left)
  key(left)
  key(left)

config talon:
  key(escape)
  insert(":split ~/.talon/user/\n")

config talon shell:
  # zsh
  key(escape)
  insert(":split ~/.talon/user/knausj_talon/apps/mac/zsh.talon\n")

config talon the:
  # vim talon
  key(escape)
  insert(":split ~/.talon/user/knausj_talon/apps/mac/vim.talon\n")

config talon keys:
  key(escape)
  insert(":split ~/.talon/user/knausj_talon/code/keys.py\n")


config tex:
  # tmux
  key(escape)
  insert(":split ~/.tmux.conf\n")

config snips:
  # ultisnips
  key(escape)
  insert("\\vu")

expand:
  # ultisnips
  key(ctrl-l)

expand <phrase>:
  key(escape)
  key(a)
  insert(phrase)
  key(ctrl-l)
