#!/usr/bin/env bash

for plugin in ~/.config/tmux/plugins/*; do
	cd $plugin;
	source *.tmux;
done
