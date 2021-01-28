# XDG base directories
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share:"${XDG_DATA_DIRS}"

# Terminfo
export TERMINFO="${XDG_DATA_HOME}"/terminfo
export TERMINFO_DIRS="${XDG_DATA_HOME}"/terminfo:/usr/share/terminfo

# Misc
export INPUTRC="${XDG_CONFIG_HOME}"/readline/inputrc
export LESSHISTFILE=-

# Neovim
export EDITOR=nvim
export VISUAL="${EDITOR}"

# Rust
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup

# X11
export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority

# Paths
export PATH="${HOME}"/.local/bin:"${CARGO_HOME}"/bin:/var/lib/flatpak/exports/bin:"${PATH}"
export MANPATH="${HOME}"/.local/share/man:"${MANPATH}"

if >/dev/null command -v startx && [ /dev/tty1 == "$(tty)" ]; then
	exec startx "$(which dbus-run-session)" dwm
fi
