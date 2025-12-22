# dotfiles

This is a bare git repo for my dotfiles - a method of managing dotfiles that uses only git. 

If you're interested in setting something up similar then [check out this post](https://racedorsey.com/posts/2025/bare-git-repo-dotfiles/), or see below for the CLI-only instructions without commentary: 

## Initial set-up
```bash
$ DOTFILES=$HOME/dev/dotfiles.git
$ git init --bare $DOTFILES
Initialized empty Git repository in /home/rogue/dev/dotfiles.git/
$ alias gitdf='git --git-dir=$DOTFILES --work-tree=$HOME'
$ gitdf config status.showUntrackedFiles no
$ gitdf add ~/.config/hypr/
$ gitdf add ~/.config/kitty/
$ gitdf add ~/.config/waybar/
$ gitdf add ~/.bashrc
$ gitdf status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   .bashrc
	new file:   .config/hypr/hyprland.conf
	new file:   .config/hypr/hyprpaper.conf
	new file:   .config/kitty/current-theme.conf
	new file:   .config/kitty/kitty.conf
	new file:   .config/waybar/config
	new file:   .config/waybar/hypr-shared.json
	new file:   .config/waybar/power_menu.xml
	new file:   .config/waybar/scripts/toggle-audio.sh
	new file:   .config/waybar/style.css

Untracked files not listed (use -u option to show untracked files)

$ gitdf commit -m "initial commit"
[main (root-commit) 611e16e1b4] initial commit
 12 files changed, 1228 insertions(+)
 create mode 100644 .bashrc
 create mode 100644 .config/hypr/hyprland.conf
 create mode 100644 .config/hypr/hyprpaper.conf
 create mode 100644 .config/kitty/current-theme.conf
 create mode 100644 .config/kitty/kitty.conf
 create mode 100644 .config/waybar/config
 create mode 100644 .config/waybar/hypr-shared.json
 create mode 100644 .config/waybar/power_menu.xml
 create mode 100755 .config/waybar/scripts/toggle-audio.sh
 create mode 100644 .config/waybar/style.css
$ gitdf remote add origin ssh://git@codeberg.org/racehd/dotfiles.git
$ gitdf push --set-upstream origin main
Enumerating objects: 20, done.
Counting objects: 100% (20/20), done.
Delta compression using up to 32 threads
Compressing objects: 100% (19/19), done.
Writing objects: 100% (20/20), 12.52 KiB | 12.52 MiB/s, done.
Total 20 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To ssh://codeberg.org/racehd/dotfiles.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```

Then make sure to add a `gitdf` alias to your shell's rc file for future usage.

## important commands

This method of storing dotfiles uses only basic git, though with an alias `gitdf`. Here are some commands that will be useful if you need a refresher: 

- See changed files
    ```bash
    gitdf status
    ```

- See diffs

    ```bash
    gitdf diff
    ```

- Add all changes to tracked files

    ```bash
    gitdf add -u
    ```

- Commit changes

    ```bash
    gitdf commit -m "update dotfiles"
    ```

- Push to remote

    ```bash
    gitdf push
    ```

- See all tracked files
    ```bash
    gitdf ls-files
    ```

- Add new tracked files/dir

    ```bash
    gitdf add ~/path/to/dir/
    gitdf add ~/path-to/file
    ```

- Remove Files from tracking but keep locally

    ```bash
    gitdf rm --cached ~/path/to/file
    ```
