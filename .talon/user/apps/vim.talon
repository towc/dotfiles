app: Vim
app: Code
app: /.*/
and title: /vim/i

-
# delete for normal mode
# clear for insert/ex mode

delete [around] word: key(d a w)
clear word: key(ctrl-w)
change [in] word: key(escape c i w)
change [in] quotes: key(escape c i ')
change [in] double: key(escape c i ")
change [in] (call | paren): key(escape c i ()

change until: key(c t)
change find: key(c f)
delete until: key(d t)
delete back until: key(d T)
delete find: key(d f)
delete back find: key(d F)
delete: key(x)

indent: key(> >)
out dent: key(< <)

visual: key(escape v)
visual to: key(escape v t)
visual find: key(escape v f)
visual line: key(escape shift-v)
visual block: key(escape ctrl-v)
yank line: key(escape y y)
paste: key(p)
paste before: key(shift-p)
join lines: key(shift-j)

go until: key(t)
go find: key(f)
go back until: key(shift-t)
go back find: key(shift-f)

delete line: key(escape d d)
delete remaining line: key(escape shift-d)
change line: key(escape c c)
change remaining line: key(escape shift-c)

clear line:
  # in ex mode
  key(ctrl-u)

insert line up: key(m z shift-o escape ` z)

insert line down:
    key(m z o escape)
    sleep(50ms)
    key(` z)


insert last line: key(shift-o)
insert line: key(o)

go end: key(shift-g)
go start: key(g g)
go center: key(z z)
go match: key(%)
go back: key(ctrl-o)
go forward: key(ctrl-i)

go (block | paragraph) [down]: key(})
go (block | paragraph) up: key({)
go previous (block | paragraph): key({)
go line: key(:)

go word [(east | right)]: key(w)
go big word [(east | right)]: key(W)
go word (left | west): key(b)
go big word (left | west): key(B)
go previous word: key(b)
go previous big word: key(B)

move window (right | east): key(ctrl-w shift-l)
move window (up | north): key(ctrl-w shift-k)
move window (down | south): key(ctrl-w shift-j)
move window (left | west): key(ctrl-w shift-h)

switch global:
  insert(":%s///g")
  key(left left left)
switch global cursor: key(\ t n)
switch global cursor <phrase>:
  key(\ t n)
  insert(phrase)
switch cursor:
  insert(":s/")
  key(crtl-r ctrl-w)
  insert("//g")
  key(left left)
switch cursor <phrase>:
  insert(":s/")
  key(crtl-r ctrl-w)
  insert("/{phrase}/g")
  key(left left)
switch:
  insert(":s///g")
  key(left left left)
  
file save: key(ctrl-s)
quit: key(ctrl-q)

next: key(n)
previous: key(shift-n)
search: key(/)
search cursor: key(/ ctrl-r ctrl-w)
search <phrase>:
  key(/)
  insert(phrase)

find file: insert("\\zx")
find text: insert("\\zv")

catch: key(escape q)
play: key(escape @)

nope: key(escape u)
actually: key(ctrl-r)

append: key(a)
append line: key(shift-a)

config vim:
  # vim
  key(escape)
  insert("\\ve")
config new:
  key(escape)
  insert(":split ~/.talon/user/apps/.talon")
  key(left)
  key(left)
  key(left)
  key(left)
  key(left)
  key(left)
config talon:
  key(escape)
  insert(":split ~/.talon/user/\n")
  insert(":cd ~/.talon/user\n")
  key(\ z x)
config talon shell:
  # zsh
  key(escape)
  insert(":split ~/.talon/user/apps/zsh.talon\n")
config talon vim:
  # vim talon
  key(escape)
  insert(":split ~/.talon/user/apps/vim.talon\n")
config talon keys:
  key(escape)
  insert(":split ~/.talon/user/code/keys.py\n")
config i three:
  key(escape)
  insert(":split ~/.talon/user/misc/i3.talon\n")
config tex:
  # tmux
  key(escape)
  insert(":split ~/.tmux.conf\n")
config snips:
  # ultisnips
  key(escape)
  insert("\\vu")

# ultisnips
expand: key(ctrl-l)
expand <phrase>:
  key(escape a)
  insert(phrase)
  key(ctrl-l)
