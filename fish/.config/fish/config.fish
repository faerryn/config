if test -z "$fish"
	set -x fish (which fish)
	exec sh -l -c fish
end
