# Tmux config

To get the tmux config up and running when cloning these dotfiles some additional setup is required...

`tmux.conf` have dependencies on Tmux Plugin Manager (TPM) [https://github.com/tmux-plugins/tpm]
This is the last line in `tmux.conf`

```bash
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.config/tmux/plugins/tpm/tpm'
```

For this to initialize properly you will first need to clone tpm

run:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

source tmux, `prefix + r` inside a tmux session

Install plugins by `prefix + I`
