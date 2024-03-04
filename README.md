# Dotfiles

Made some major changes, changes big enough to merit a new repo! No more bare repo, and custom scripts
for managing difference in environments.
These dotfiles collection use a combination of `ansible`, `chezmoi`, `1password`, `Go templates`
to create a great portable robust way to manage configurations across different machines.

---

## Components

### Ansible

Install packages, set system settings, install chezmoi and apply dotfiles, install tmux + plugins and more... Check the [roles](./scripts/common/ansible/roles) for more info.

### Chezmoi

Leverage templates to handle host differences in a clean way, incorporates the use of 1password to supply my own credentials.
Config files for `zsh`, `nvim`, `tmux`, `alacritty`, `git`, `karabiner`, `vscode`, `bat`, and `hammerspoon`.

## Setup

Install everything with single curl command:

```bash
curl -fsSL https://raw.githubusercontent.com/mattjh1/dotfiles/main/scripts/setup.sh | sh -s -- --all
```

Some of the configurations relies on details stored in my personal 1password vault, if you run the
playbook a second time without my 1password configured, you're gonna have a bad time :p
No fix for this as of yet, if someone wants my config i might deal with it.

## Inspiration

[shmileee dotfiles](https://github.com/shmileee/dotfiles)

[Michael Bynens and his awesome macos settings](https://github.com/mathiasbynens/dotfiles/tree/main)

[Jogendra dotfiles](https://github.com/jogendra/dotfiles)

[Jason Rudolph keyboard centric setup](https://github.com/jasonrudolph/keyboard)
