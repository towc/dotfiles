if status is-login
	source ~/.config/fish/login.fish
end

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

function fish_user_key_bindings
	# bind shift-up and shift-down to attribute search
	# these are bound to alt-up and alt-down in the defaults
	# but we use them in tmux, so we add these alternatives here
	bind $argv \e\[1\;2A history-token-search-backward
	bind $argv \e\[1\;2B history-token-search-forward
  #fish_vi_key_bindings insert
  bind -M insert \ck 'fg %'
end

function fish_prompt
	set last_status $status
	if test -n "$SSH_CONNECTION"
		set_color $fish_color_cwd_root
		printf '[%s] ' (uname -n)
		set_color normal
	end
	set_color $fish_color_cwd
	printf '%s' (prompt_pwd)
	set_color normal
	printf '%s ' (__fish_git_prompt)
	set_color normal
end

alias uptime='uptime -p'
alias tree='tree -FC'
set -gx PATH ./node_modules/.bin ~/.npm-global/bin ~/.bin ~/.local/bin ~/.cargo/bin /snap/bin $PATH
set -gx RUST_SRC_PATH /usr/local/src/rust/src

export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

export RUST_SRC_PATH=(rustc --print sysroot)/lib/rustlib/src/rust/src

# # Base16 Shell
# if status --is-interactive
#     eval sh /home/user/.base16-manager/chriskempson/base16-shell/scripts/base16-ashes.sh
# end

test -s /home/user/.nvm-fish/nvm.fish; and source /home/user/.nvm-fish/nvm.fish
