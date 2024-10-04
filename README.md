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

Leverage templates to handle host differences in a clean way.
Config files for `zsh`, `nvim`, `tmux`, `alacritty`, `git`, `karabiner`, `vscode`, `bat`, and `hammerspoon`.

## Setup

Install everything with single curl command:

```bash
curl -fsSL https://raw.githubusercontent.com/mattjh1/dotfiles/main/scripts/setup.sh | sh -s -- --all
```

Some of the configurations relies on my 1password vault, for example:

- [ssh config](./dotfiles/private_dot_ssh/private_config.tmpl)
- [zsh-secrets.tmpl](./dotfiles/dot_config/zsh/zsh-secrets.tmpl)

The install will still work, but don't expect to get the secret sauce

## Inspiration

[shmileee dotfiles](https://github.com/shmileee/dotfiles)

[Michael Bynens and his awesome macos settings](https://github.com/mathiasbynens/dotfiles/tree/main)

[Jogendra dotfiles](https://github.com/jogendra/dotfiles)

[Jason Rudolph keyboard centric setup](https://github.com/jasonrudolph/keyboard)
