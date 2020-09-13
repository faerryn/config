BEGIN {
	ORS = "";

	fatal = 0;

	oid = "";
	head = "";
	untracked = 0;
	staged = 0;
	unstaged = 0;

	upstream = "";
	unmerged = 0;
	ahead = 0;
	behind = 0;
}

$1 == "fatal:" { fatal = 1; }

$2 == "branch.oid" { oid = $3; }
$2 == "branch.head" { head = $3; }
$1 == "?" { untracked += 1; }
$2 == "branch.ab" {
	ahead = $3 + 0;
	behind = $4 * -1;
}

$2 == "branch.upstream" { upstream = $3; }
$1 == "u" { unmerged += 1; }
$1 == "1" || $1 == "2" {
	split($2, chars, "")
	if (chars[2] != ".")
		unstaged += 1; 
	if (chars[1] != ".")
		staged += 1; 
}

END {
	if (fatal == 1)
		exit(1); 

	print " ["
	print " %F{blue}:" substr(oid, 1, 8) "%f";
	print " %F{yellow}" head "%f";
	if (untracked > 0)
		print " %F{yellow}?" untracked "%f"; 
	if (unstaged > 0)
		print " %F{red}-" unstaged "%f"; 
	if (staged > 0)
		print " %F{green}+" staged "%f"; 
	print " ]"

	if (upstream != "") {
		print " ["
		print " %F{yellow}" upstream "%f";
		if (unmerged > 0)
			print " %F{red}!" unmerged "%f"; 
		if (ahead > 0)
			print " %F{cyan}↑" ahead "%f"; 
		if (behind > 0)
			print " %F{magenta}↓" behind "%f"; 
		print " ]"
	}
}
