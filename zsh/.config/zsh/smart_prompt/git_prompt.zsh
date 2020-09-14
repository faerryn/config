# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
0=${(%):-%N}
PERSONAL_GITPROMPT_AWK="${0:A:h}/smart_prompt.awk"

function personal_prompt_async () { 2>&1 git -C "$1" --no-optional-locks status --branch --porcelain=v2 | awk -f "$PERSONAL_GITPROMPT_AWK" }
function personal_prompt_callback () {
	[[ -n "$5" ]] && return
	PERSONAL_PROMPT_GIT="$3"
	zle reset-prompt
}
function personal_prompt () {
	>/dev/null 2>&1 command -v async_init || return
	async_flush_jobs personal_prompt_worker
	while ! {
		PERSONAL_PROMPT_GIT=
		2>/dev/null async_job personal_prompt_worker personal_prompt_async $PWD
	} {
		async_start_worker personal_prompt_worker
		async_register_callback personal_prompt_worker personal_prompt_callback
	}
}

PERSONAL_PROMPT_NIX=
[[ -n "$IN_NIX_SHELL" ]] && PERSONAL_PROMPT_NIX+=' [ %F{green}$IN_NIX_SHELL%f ]'
PERSONAL_PROMPT_GIT=
PERSONAL_PROMPT_DIR=' [ %F{blue}%3~%f ]'
PERSONAL_PROMPT_JOBS='%(1j. [ %(2j.%j .)%F{yellow}*%f ].)'
PERSONAL_PROMPT_BANG=' %(0?..%F{red})%(!.#.$)%f'

setopt PROMPT_SUBST
PROMPT='$PERSONAL_PROMPT_NIX$PERSONAL_PROMPT_DIR$PERSONAL_PROMPT_JOBS$PERSONAL_PROMPT_BANG '
RPROMPT='$PERSONAL_PROMPT_GIT'

precmd_functions+=(personal_prompt)
