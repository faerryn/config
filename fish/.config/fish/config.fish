if test -z "$fish"
	set -x fish flounder
	exec sh -l -c fish
end

set -x LDFLAGS (string split -r ' ' -- $LDFLAGS)
