if status --is-login
	exec sh -l -c fish
end

set -x CFLAGS (string split -r ' ' -- "$CFLAGS")
set -x CXXFLAGS (string split -r ' ' -- "$CXXFLAGS")
set -x LDFLAGS (string split -r ' ' -- "$LDFLAGS")
