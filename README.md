# dotfiles

This is a bare git repo for my dotfiles - a method of managing dotfiles that uses only git.

If you're interested in setting something up similar then [check out this post](https://racedorsey.com/posts/2025/bare-git-repo-dotfiles/), or see below for the CLI-only instructions without commentary:

## Initial set-up

```bash
$ DOTFILES=$HOME/.config/dotfiles.git
$ git init --bare $DOTFILES
$ alias gitdf='git --git-dir=$DOTFILES --work-tree=$HOME'
$ gitdf config status.showUntrackedFiles no
$ gitdf add ~/.config/hypr/
$ gitdf add ~/.config/kitty/
$ gitdf add ~/.config/waybar/
$ gitdf add ~/.bashrc

$ gitdf commit -m "initial commit"
$ gitdf remote add origin yourremote@here.org/racehd/dotfiles.git
$ gitdf push --set-upstream origin main
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
