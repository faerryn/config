# XDG base directories
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share:"${XDG_DATA_DIRS}"

# Terminfo
export TERMINFO="${XDG_DATA_HOME}"/terminfo
export TERMINFO_DIRS="${XDG_DATA_HOME}"/terminfo:/usr/share/terminfo

# Neovim
export EDITOR=nvim
export VISUAL="${EDITOR}"

# Rust
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup

# Misc
export FZF_DEFAULT_COMMAND="fd --hidden --ignore-file ${XDG_CONFIG_HOME}"
export GRADLE_USER_HOME="${XDG_DATA_HOME}"/gradle
export INPUTRC="${XDG_CONFIG_HOME}"/readline/inputrc
export LESSHISTFILE=-
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}"/node_repl_history
export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority

# Paths
export PATH="${HOME}"/.local/bin:"${CARGO_HOME}"/bin:"${PATH}"
export MANPATH="${HOME}"/.local/share/man:"${MANPATH}"
