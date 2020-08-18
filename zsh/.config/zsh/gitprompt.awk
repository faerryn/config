BEGIN {
    ORS = "";
    fatal = 0;
    oid = "";
    head = "";
    upstream = "";
    ahead = 0;
    behind = 0;
    untracked = 0;
    unmerged = 0;
    staged = 0;
    unstaged = 0;
}
$1 == "fatal:" {
    fatal = 1;
}
$2 == "branch.oid" {
    oid = $3;
}
$2 == "branch.head" {
    head = $3;
}
$2 == "branch.upstream" {
    upstream = $3;
}
$2 == "branch.ab" {
    ahead = $3 + 0;
    behind = $4 * -1;
}
$1 == "?" {
    ++untracked;
}
$1 == "u" {
    ++unmerged;
}
$1 == "1" || $1 == "2" {
    split($2, arr, "");
    if (arr[1] != ".") {
	++staged;
    }
    if (arr[2] != ".") {
	++unstaged;
    }
}
END {
    if (fatal == 1) {
	exit(1);
    }

    print " ["
    if (head == "(detached)") {
	print " %F{blue}:" substr(oid, 1, 8) "%f";
    } else {
	print " %F{blue}HEAD%f";
	if (upstream != "") {
	    print " %F{yellow}" upstream "%f";
	} else {
	    print " %F{yellow}" head "%f";
	}
    }
    print " ]"

    if (ahead + behind + unmerged > 0) {
	print " ["
	if (ahead > 0) {
	    print " %F{yellow}↑" ahead "%f";
	}
	if (behind > 0) {
	    print " %F{yellow}↓" behind "%f";
	}
	if (unmerged > 0) {
	    print " %F{red}!" unmerged "%f";
	}
	print " ]"
    }

    if (staged + unstaged + untracked > 0) {
	print " ["
	if (staged > 0) {
	    print " %F{green}+" staged "%f";
	}
	if (unstaged > 0) {
	    print " %F{red}-" unstaged "%f";
	}
	if (untracked > 0) {
	    print " %F{yellow}?" untracked "%f";
	}
	print " ]"
    }
}