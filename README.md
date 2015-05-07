tmux logging ssh
================

This [tpm](https://github.com/tmux-plugins/tpm) plugin logs ssh sessions.

## Requirements

1. tmux
2. [tpm](https://github.com/tmux-plugins/tpm)

## Install

Add below line to your `~/.tmux.conf`

```bash
set-option -g @tpm_plugins "   \
    tmux-plugins/tpm           \
    knakayama/tmux-logging-ssh \
"
```

then, press `Prefix + I` in tmux session.

## Usage

Default ssh key binding is `Prefix + S`. If you change this key binding, set below line to your `~/.tmux.conf`.

```bash
set-option -g @ssh 'x' # or your favorite key binding
```

## Todo

- [] Remove hard codes.
- [] Create the option to change log path.
- [] Support [tmuxinator](https://github.com/tmuxinator/tmuxinator) integration.
- [] Create clustering ssh option.
- [] Write documents.

## License

[MIT](http://knakayama.mit-license.org/)

## Author

[knakayama](https://github.com/knakayama)
