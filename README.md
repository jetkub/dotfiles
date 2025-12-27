# mdf - manage dotfiles
A simple dotfile management system using a bare git repo. No symlinks, no complex scripts, just git. Inspired by [this blog post](https://home.codevoid.de/posts/2019-04-27_Manage_dotfiles_with_git.html).

## What this is
This setup uses a **bare git repository** stored in `~/.mdf` to track configs in your home directory. The `mdf` command is an alias that lets you use git to manage your configs.


## Why?
- Just one alias; no symlinks, scripts, or third party tools
- Config files stay in their expected locations
- Full git functionality (branches, history, etc.)
- Only track what you explicitly add
- Easy setup on new machines


## How?
I don't recommend that you clone this repo. These are my configs. However, I
want to describe how to do this yourself. Feel free to follow along.


### First time set up
1. **Create the bare repository:**
```bash
git init --bare $HOME/.mdf
```

2. **Create the alias:**

Add to your shell config wherever you like; I have a separate zsh_aliases file.
```bash
tee -a ~/.zsh/zsh_aliases << 'EOF'

# mdf alias for bare git repo dotfile management
alias mdf="git --git-dir=$HOME/.mdf/ --work-tree=$HOME"

EOF
```
Source your config so the alias works immediately
```bash
source ~/.zsh/zsh_aliases
```

3. **Configure git to hide untracked files:**

With this, `mdf status` will only show files you've explicitly added to the
repo, thus everything else in your `$HOME` directory is ignored.
Otherwise, running `mdf status` is a total mess of untracked files.
```bash
mdf config --local status.showUntrackedFiles no
```

4. **Add your first config files:**
```bash
mdf add .zshrc .zshenv .zprofile # or whatever zsh files you have
mdf add .zsh/zsh_aliases .zsh/zsh_key_binds .zsh/zsh_completions .zsh/zsh_prompt
mdf commit -m "Initial commit: zsh config"
```

5. **Add remote repo and push:**
```bash
mdf remote add origin git@gitlab.com:<username>/dotfiles.git
mdf push --set-upstream origin main
```

### New machine setup

1. **Clone the bare repository:**
```bash
git clone --bare https://gitlab.com/<username>/dotfiles.git $HOME/.mdf
```

2. **Create the alias:**
```
tee -a ~/.zsh/zsh_aliases << 'EOF'

# mdf alias for bare git repo dotfile management
alias mdf="git --git-dir=$HOME/.mdf/ --work-tree=$HOME"

EOF
```

3. **Configure git and checkout files:**
```
mdf config --local status.showUntrackedFiles no
mdf checkout
```

All set. Your dotfiles are now on your new machine and ready to use.


## Daily workflow

### Making changes
After editing your dotfiles (like `.zshrc`, `.vimrc`, etc.):

Check what you've changed
```bash
mdf status
```

Add changed files
```bash
mdf add .zshrc  # Add specific files
# OR
mdf add -u      # Add all modified tracked files, equivalent to mdf add --update
```

Commit changes
```bash
mdf commit -m "Update shell config"
```

Push to remote git repo
```bash
mdf push
```

### Getting changes on other machines
Pull latest changes. Files will update automatically. Easy.
```bash
mdf pull
```

### Adding new config files
```bash
mdf add .vim/vimrc
mdf commit -m "Add vim config"
mdf push
```

## How It Works

### The mdf alias
```bash
alias mdf="git --git-dir=$HOME/.mdf/ --work-tree=$HOME"
```

This tells git:
- Store **git data** in `~/.mdf/` (instead of `.git/`)
- Use your entire home directory `~` as the **working tree**

Your dotfiles can live anywhere in your home directory (`~/.zshrc`, `~/.vim/vimrc/`,
etc.) while git's tracking data stays contained in `~/.mdf/`.

The key is that git can see your entire home directory but will only track files you explicitly add
with `mdf add`. Combined with `mdf config --local status.showUntrackedFiles no`, you get a clean
workflow where `mdf status` only shows your managed dotfiles, not every file in your home
directory.

Essentially, you get git's full power for managing configs without turning your home directory into
a messy git repo.

### `git` bare repository explained
A bare repository contains only git's tracking data (objects, refs, etc.)
without a working directory. By setting `$HOME` as the working tree, git treats
your home directory as the repository, but only tracks files you explicitly add.


### `checkout` vs `pull` - when to use which

**`mdf checkout`** - Use for:
- **Setup on a new machine** (placing files from git into home dir)
- **Overwriting local changes** you want to discard
- **Switching branches** (if you use multiple config branches)

**`mdf pull`** - Use for:
- **Daily syncing** (getting updates from other machines)
- **Regular workflow** (automatically updates your actual tracked files)

**Key difference**: `pull` fetches from remote AND updates your files.
`checkout` only updates files from what's already in local git.

## Useful commands

```bash
# See what's changed
mdf status

# See differences in files
mdf diff
mdf diff .zshrc     # Diff specific file

# Quick commit all changes
mdf commit -am "Quick update"

# View git history
mdf log --oneline

# See what files are being tracked
mdf ls-files

# Stop tracking a file (but keep the file)
mdf rm --cached .some-file

# Overwrite local file with git version
mdf checkout -- .zshrc
```

## Troubleshooting

### "Files would be overwritten by checkout"
If `mdf checkout` fails with this error, you have existing files that conflict:

```bash
# Option 1: Backup existing files
mkdir -p ~/.config-backup
mdf checkout 2>&1 | grep -E '^\s+' | awk '{print $1}' | xargs -I{} mv {} ~/.config-backup/

# Option 2: Force overwrite (destroys local files)
mdf checkout -f

# Then complete checkout
mdf checkout
```

### "Repository not found" when pushing
Make sure you've created the remote repository on GitLab/GitHub/wherever first:

```bash
# Check current remote
mdf remote -v
# Add remote
mdf remote add origin git@gitlab.com:<username>/dotfiles.git
# Or change remote
mdf remote set-url origin git@github.com:<username>/dotfiles.git
```

### Alias not working
Make sure the alias is in your shell config and sourced.

Check if alias exists:
```bash
alias mdf
```
If no output, then:

Add to .zsh/zsh_aliases or wherever you store aliases:
```bash
tee -a ~/.zsh/zsh_aliases << 'EOF'

# mdf alias for bare git repo dotfile management
alias mdf="git --git-dir=$HOME/.mdf/ --work-tree=$HOME"

EOF
```

Or just set for current session:
```
alias mdf="git --git-dir=$HOME/.mdf/ --work-tree=$HOME"
```

### Too many untracked files showing
Run this to hide untracked files from `mdf status`:

```bash
mdf config --local status.showUntrackedFiles no
```

## What files should I track? Rule of thumb:

Track configuration files you want to sync across machines:

**Shell configs:**
- `.zshrc`, `.zshenv`, `.zprofile`
- `.zsh/` directory contents
- `.bashrc`, `.bash_profile`

**Editor configs:**
- `.vimrc`, `.vim/`
- `.config/nvim/`

**Tool configs:**
- `.gitconfig`
- `.tmux.conf`
- `.config/` subdirectories for various tools

**Don't track:**
- Cache directories (`.cache/`, `.zcompdump`)
- Sensitive files (`.ssh/`, API keys)
- Large binary files
- Temp files

## Advanced Usage
You have the power of `git`!

### Multiple config branches

You can maintain different configurations (work, personal, etc.):

```bash
mdf checkout -b work-config
# Make work-specific changes
mdf add .gitconfig
mdf commit -m "Work git config"
mdf push -u origin work-config

# Switch back to personal
mdf checkout main
```

### Selective sync
Only sync specific files to a machine:

```bash
mdf checkout main -- .vim/vimrc     # Only checkout .vim/vimrc
```
