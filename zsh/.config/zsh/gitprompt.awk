# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
# modified from https://github.com/woefe/git-prompt.zsh
# Copyright (c) 2019 Wolfgang Popp
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

BEGIN {
	ORS = "";

	fatal = 0;

	head = "";
	oid = "";
	upstream = "";

	unmerged = 0;
	ahead = 0;
	behind = 0;

	staged = 0;
	unstaged = 0;
	untracked = 0;
}

$1 == "fatal:" { fatal = 1; }

$2 == "branch.head" { head = $3; }
$2 == "branch.oid" { oid = $3; }
$2 == "branch.upstream" { upstream = $3; }

$1 == "u" { unmerged += 1; }
$2 == "branch.ab" {
	ahead = $3 + 0;
	behind = $4 * -1;
}

$1 == "1" || $1 == "2" {
	split($2, chars, "")
	if (chars[1] != ".") { staged += 1 }
	if (chars[2] != ".") { unstaged += 1 }
}
$1 == "?" { untracked += 1; }

END {
	if (fatal == 1) { exit(1); }

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

	if (unmerged + ahead + behind > 0) {
		print " ["
		if (unmerged > 0) { print " %F{red}!" unmerged "%f"; }
		if (ahead > 0) { print " %F{yellow}↑" ahead "%f"; }
		if (behind > 0) { print " %F{yellow}↓" behind "%f"; }
		print " ]"
	}

	if (staged + unstaged + untracked > 0) {
		print " ["
		if (staged > 0) { print " %F{green}+" staged "%f"; }
		if (unstaged > 0) { print " %F{red}-" unstaged "%f"; }
		if (untracked > 0) { print " %F{yellow}?" untracked "%f"; }
		print " ]"
	}
}
