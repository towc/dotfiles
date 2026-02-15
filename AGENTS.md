# Agent Guide for Configuration Management

This document provides guidance for AI coding agents working with this personal Linux configuration management system. The configs are primarily stored in `~/.config/` and home directory dotfiles.

## Overview

**Purpose**: Personal Linux configuration management for Pop!_OS/Ubuntu development environment  
**OS**: Pop!_OS 22.04 LTS (based on Ubuntu Jammy)  
**Window Manager**: GNOME with Pop Shell (tiling window manager extension)  
**Primary Configs**: Shell (Zsh), Terminal (Kitty), Git, Tmux, Neovim, OpenCode, and various CLI tools  
**Scope**: All tracked dotfiles including `~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/`, `~/.config/opencode/`, etc.  
**Dotfiles Repo**: Bare git repository at `~/.dotfiles-git/` (GitHub: `towc/dotfiles`)

## OpenCode Source Code

**Location**: `~/git/github/anomalyco/opencode`  
**Purpose**: OpenCode source code repository for reference when working with OpenCode features, plugins, or internals  
**Usage**: When the user asks about OpenCode functionality, check this directory for source code (run `git pull` first to get latest)  
**Key Directories**:
- `packages/opencode/src/` - Core OpenCode implementation
- `packages/plugin/src/` - Plugin system types and utilities
- `packages/opencode/src/permission/` - Permission system implementation
- `packages/web/src/content/docs/` - Documentation source

## Dotfiles Repository Management

This setup uses a **bare git repository** to track dotfiles across the home directory. This is a best-practice approach that avoids symlinks and keeps the home directory clean.

### Repository Structure
- **Location**: `~/.dotfiles-git/` (bare repository)
- **Work Tree**: `~/` (entire home directory)
- **Remote**: `git@github.com:towc/dotfiles.git`
- **Alias**: `dotfiles` (runs git commands with correct paths)

### Currently Tracked Files
The dotfiles repository currently tracks:
- `~/.config/kitty/kitty.conf` - Kitty terminal configuration
- `~/.config/nvim/init.lua` - Neovim configuration
- `~/.config/opencode/` - OpenCode configuration (when ready to track)
- `~/.zshrc`, `~/.tmux.conf`, `~/.gitconfig` - Core dotfiles (when ready to track)
- Additional dotfiles as needed (check with `dotfiles ls-files`)

### Using the Dotfiles Command

The `dotfiles` alias is defined as:
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'
```

**Common dotfiles commands:**
```bash
# View status (shows modified tracked files)
dotfiles status

# Add a file to track
dotfiles add ~/.zshrc
dotfiles add ~/.tmux.conf
dotfiles add ~/.config/kitty/kitty.conf

# Commit changes
dotfiles commit -m "Update zsh configuration"

# Push to GitHub
dotfiles push origin main

# View tracked files
dotfiles ls-files

# View diff of changes
dotfiles diff

# View commit history
dotfiles log --oneline

# Pull latest changes
dotfiles pull
```

### Quick Access Alias

Use **`oh`** to start an OpenCode session focused on dotfiles management:
```bash
oh   # Opens OpenCode with dotfiles management context
ohc  # Continue last OpenCode session for dotfiles
```

This alias automatically provides context about the bare git repository setup and the `dotfiles` command. **This is the primary way to manage ALL configurations**, including Neovim, OpenCode, shell configs, and any other dotfiles.

**Note**: The `oh` and `ohc` aliases are defined in `~/.zshrc` (lines 236-237). When modifying these aliases, edit that file directly.

### Adding New Configuration Files

When you want to track a new config file:
1. Edit the file normally (e.g., `vi ~/.zshrc`)
2. Add it to dotfiles: `dotfiles add ~/.zshrc`
3. Commit: `dotfiles commit -m "Add zsh configuration"`
4. Push: `dotfiles push`

### Important Notes

- **Don't use regular `git` commands** in `~/` - always use `dotfiles`
- The repository ignores untracked files by default (`.git` config: `status.showUntrackedFiles no`)
- **All configurations** should be managed through the dotfiles repo, including Neovim and OpenCode
- While Neovim has its own `AGENTS.md` at `~/.config/nvim/AGENTS.md`, that file should also be tracked in dotfiles
- Never commit sensitive data (API keys, tokens, etc.)
- See `~/dotfiles.md` for full setup instructions

## Key Configuration Files

### Shell Configuration (`~/.zshrc`)
- **Shell**: Zsh with oh-my-zsh
- **Theme**: agnoster (with simplified prompt via `prompt_context(){}`)
- **Key Features**:
  - Custom PATH setup with local bins, Cargo, Go, npm, etc.
  - FZF integration for fuzzy finding
  - fnm (Fast Node Manager) for Node.js version management
  - Custom cd tracking (saves last cd to `/tmp/.tmux-last-cd`)
  - Claude Code and OpenCode CLI aliases

### Tmux Configuration (`~/.tmux.conf`)
- **Prefix**: `C-b` (Ctrl+b)
- **Shell**: Zsh
- **Terminal**: xterm-256color
- **Key Features**:
  - Vim-tmux-navigator integration (smart pane switching with `C-h/j/k/l`)
  - Vi mode for copy mode
  - Mouse support enabled
  - Plugin manager: tpm (Tmux Plugin Manager)
  - Custom keybindings for session/window management
  - tmux2k theme with network and time display
  - tmux-resurrect for session persistence

### Kitty Terminal (`~/.config/kitty/kitty.conf`)
- **Font**: Hack Nerd Font Mono, size 10
- **Theme**: Custom dark color scheme (black background)
- **URL Handling**: Firefox with Ctrl modifier
- **Keybindings**: Ctrl+equal/minus for font size adjustment

### Git Configuration (`~/.gitconfig`)
- **User**: Matei Copot (matei@copot.eu)
- **Editor**: neovim
- **Merge Tool**: vimdiff
- **Default Branch**: main
- **Push Default**: current
- **Global Ignore**: `~/.gitignore_global`

### Global Git Ignore (`~/.gitignore_global`)
- Vim swap/session/undo files
- Python cache files
- AI-related directories (`.claude`, `.agents`, `.cursor/skills`)
- Personal files (`matei-*`)
- Environment files (`.env.e2e`, `.env.prod`, `.env.staging`)

## File Structure

```
~/
├── .zshrc                         # Zsh shell configuration
├── .tmux.conf                     # Tmux configuration
├── .gitconfig                     # Git configuration
├── .gitignore_global              # Global Git ignore patterns
├── .bashrc, .profile              # Bash configurations
├── .vimrc                         # Vim configuration
├── .fzf.zsh, .fzf.bash           # FZF integration
├── .lazyshell.zsh                # Custom shell utilities
├── startup-once.sh               # One-time startup script
├── startup-many.sh               # Repeatable startup script
└── .config/
    ├── kitty/                    # Kitty terminal config
    ├── gh/                       # GitHub CLI config
    ├── git/                      # Git ignore patterns
    ├── htop/                     # System monitor config
    ├── gcloud/                   # Google Cloud CLI
    ├── stripe/                   # Stripe CLI
    └── [other app configs]
```

## Code Style Guidelines

### Shell Scripts (.sh, .zsh)
- **Shebang**: `#!/bin/zsh` or `#!/bin/bash` (prefer zsh for interactive)
- **Indentation**: 2 spaces
- **Variables**: `snake_case` for local, `UPPER_CASE` for environment/exports
- **Functions**: `function name() { ... }` style preferred
- **Quoting**: Always quote variables: `"$var"` not `$var`
- **Error Handling**: Use `set -e` for strict error handling when appropriate

### Configuration Files
- **Comments**: Use `#` for comments
- **Formatting**: Keep logical sections separated by blank lines
- **Consistency**: Match existing style in each config file
- **Documentation**: Add comments explaining non-obvious configurations

### Naming Conventions
- **Config files**: Lowercase with dots (`.zshrc`, `.tmux.conf`)
- **Scripts**: Lowercase with dashes (`startup-once.sh`)
- **Aliases**: Lowercase, short and memorable (`cn`, `cr`, `cdl`)
- **Functions**: snake_case or camelCase depending on context

## Common Operations

### Shell Configuration
```bash
# Edit zsh config
vi ~/.zshrc

# Reload zsh config
source ~/.zshrc

# Test zsh syntax
zsh -n ~/.zshrc
```

### Tmux Operations
```bash
# Edit tmux config
vi ~/.tmux.conf

# Reload tmux config (inside tmux)
<prefix>:source-file ~/.tmux.conf

# Or from command line
tmux source-file ~/.tmux.conf

# Install/update plugins
<prefix>I  # Inside tmux after adding plugins
```

### Git Configuration
```bash
# Edit git config
git config --global --edit

# View current config
git config --global --list

# Test gitignore patterns
git check-ignore -v <filename>
```

## Key Aliases & Functions

### Claude Code Aliases
- `cn` → `claude` (new session)
- `cr` → `claude --resume` (resume last)
- `cc` → `claude --continue` (continue last)

### OpenCode Aliases
- `on` → `opencode` (new session)
- `oc` → `opencode --continue` (continue last)
- `op` → `opencode --prompt` (with custom prompt)
- `oh` → **Start OpenCode for dotfiles management (manages ALL configs: Neovim, OpenCode, Zsh, Tmux, etc.)**
- `ohc` → **Continue OpenCode session for dotfiles management**

### OpenCode Plugins
Plugins are defined in `~/.config/opencode/opencode.json` under the `plugin` array. When removing a plugin:
1. Remove it from the `plugin` array in `opencode.json`
2. Delete the plugin directory from `~/.config/opencode/plugins/`
3. Delete any agent definition files from `~/.config/opencode/agents/`
4. Restart OpenCode

Common locations:
- Plugins: `~/.config/opencode/plugins/<plugin-name>/`
- Agent definitions: `~/.config/opencode/agents/<name>.md`

### Custom Functions
- `cdl` - CD to last directory (tracked in `/tmp/.tmux-last-cd`)
- `cdm <dir>` - Create directory and cd into it
- `sspn <name>` - Stop process by name
- `cntn <name>` - Continue process by name
- `killn <name>` - Kill process by name

### Utility Aliases
- `myip4` - Get IPv4 address via OpenDNS
- `kdiff` - Kitty diff viewer
- `L` - Less with color support

## Tmux Keybindings

### Session Management
- `<prefix>k` - Switch to next session and kill current
- `<prefix>a` - New session
- `<prefix>t` - Toggle status bar

### Navigation
- `C-h/j/k/l` - Navigate panes/windows/sessions (vim-tmux-navigator)
  - At left edge: previous window
  - At right edge: next window
  - At top edge: previous session
  - At bottom edge: next session
- `C-\` - Last pane

### Copy Mode
- `<prefix>[` - Enter copy mode
- Vi keybindings (`v` to select, `y` to copy)
- `<prefix>v` - Paste buffer

## Important Conventions

### DO:
- Preserve existing formatting and style in config files
- Test changes before committing (source configs, restart services)
- Add comments explaining complex configurations
- Keep shell scripts POSIX-compatible when possible
- Use absolute paths for critical scripts
- Use `oh` command for managing any and all configuration files
- Track configuration changes in the dotfiles repository

### DON'T:
- Don't use regular `git` commands in `~/` - always use the `dotfiles` alias
- Don't add plugins to tmux/zsh without discussing first
- Don't commit sensitive data (API keys, tokens) - use `secrets.lua` or env files
- Don't remove commented code without understanding its purpose
- Don't break vim-tmux-navigator integration in tmux config
- Don't change the tmux prefix or leader key without explicit request
- Don't forget to commit configuration changes to the dotfiles repository

## Development Tools & Environment

### Version Managers
- **fnm**: Fast Node Manager (preferred over nvm)
- **Cargo**: Rust package manager
- **Go**: Go binary in `~/go/bin`

### CLI Tools Available
- **gh**: GitHub CLI (with `co` alias for `pr checkout`)
- **fzf**: Fuzzy finder (integrated in shell and vim)
- **docker**: Docker Desktop for containers
- **gcloud**: Google Cloud CLI
- **stripe**: Stripe CLI for testing
- **kitty**: Terminal with advanced features
- **bat**: Syntax highlighting (theme: Visual Studio Dark+)

### Environment Variables
- `$JAVA_HOME`: Java 11 OpenJDK
- `$WORK`: Work directory (`/home/user/work/toptal/deepchannel`)
- `$DENO_INSTALL`: Deno installation path
- `$ANDROID_SDK`: Android SDK path
- `$RUST_SRC_PATH`: Rust source for IDE integration
- `$BAT_THEME`: Visual Studio Dark+

## Special Notes from .claude/CLAUDE.md

### File Management
- **Temporary files**: Always use `/tmp` for one-time scripts, analysis reports, etc.
- **Documentation**: Only create permanent docs (README.md, etc.) when explicitly requested
- Never create `SECURITY_REVIEW.md`, `ANALYSIS.md`, `TODO.md`, `NOTES.md` in project root

### Context Management
- Use subagents (Task tool) for self-contained work (docs, isolated refactoring, analysis)
- Don't use subagents for code you'll reference soon or incremental changes

### Development Workflow
- **Never run `npm run build`** - breaks dev server (only if explicitly requested)
- Use `npx tsc --noEmit` for TypeScript verification instead
- Use `gh issue view <number> --repo anomalyco/opencode` to fetch GitHub issues

### Supabase MCP Auth Workaround
If you get "Unrecognized client_id" error with Supabase MCP, it may be caused by having MCP servers with the same name but different configs (e.g., different project_refs) across multiple projects. Fix: rename one of the MCP servers to a unique name in its project, then re-authenticate.

## Common Tasks

### Managing Dotfiles (Tracked Configurations)
```bash
# Check what files have been modified
dotfiles status

# View changes to tracked files
dotfiles diff

# Add changes to a tracked file
dotfiles add ~/.zshrc

# Commit changes
dotfiles commit -m "Update shell configuration"

# Push to GitHub
dotfiles push origin main

# Add a new file to track
dotfiles add ~/.config/new-app/config.yml
dotfiles commit -m "Track new-app configuration"
```

### Adding Shell Alias
1. Open `~/.zshrc` with editor
2. Add alias in appropriate section
3. Source config: `source ~/.zshrc`
4. Test the alias
5. Commit to dotfiles: `dotfiles add ~/.zshrc && dotfiles commit -m "Add new alias"`

### Adding Tmux Plugin
1. Add `set -g @plugin 'author/plugin'` to `~/.tmux.conf`
2. Reload config: `<prefix>:source-file ~/.tmux.conf`
3. Install plugins: `<prefix>I`
4. Commit to dotfiles: `dotfiles add ~/.tmux.conf && dotfiles commit -m "Add tmux plugin"`

### Modifying Git Config
1. Edit with `git config --global <key> <value>`
2. Or manually edit `~/.gitconfig`
3. Verify with `git config --global --list`
4. Commit to dotfiles: `dotfiles add ~/.gitconfig && dotfiles commit -m "Update git config"`

### Creating Shell Script
1. Create file with `.sh` extension
2. Add shebang: `#!/bin/zsh` or `#!/bin/bash`
3. Make executable: `chmod +x script.sh`
4. Add to PATH if needed (preferably `~/.bin/`)
5. Optionally track in dotfiles if it's a personal utility

---

**Note**: This configuration prioritizes a clean, terminal-focused development workflow with Zsh, Tmux, and Kitty as the foundation. When helping, respect existing patterns and test changes thoroughly before suggesting them.
