#!/bin/sh
for plugin in ~/.config/tmux/plugins/*/*.tmux; do
	$plugin
done
