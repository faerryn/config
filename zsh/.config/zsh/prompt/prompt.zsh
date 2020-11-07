# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
PERSONAL_GITPROMPT_AWK="$(dirname ${0})/git.awk"

function personal_prompt_async () {
	2>&1 git -C "${1}" --no-optional-locks status --branch --porcelain=v2 | awk -f "${PERSONAL_GITPROMPT_AWK}"
}
function personal_prompt_callback () {
	[[ -n "${5}" ]] && return
	RPROMPT="${3}"
	zle reset-prompt
}
function personal_prompt () {
	>/dev/null 2>&1 command -v async_init || return
	async_flush_jobs personal_prompt_worker
	while ! {
		RPROMPT=
		2>/dev/null async_job personal_prompt_worker personal_prompt_async ${PWD}
	} {
		async_start_worker personal_prompt_worker
		async_register_callback personal_prompt_worker personal_prompt_callback
	}
}

PROMPT=' [ %F{magenta}%n%f@%F{magenta}%m%f %F{blue}%3~%f ]%(1j. %F{yellow}%(2j.%j .)*%f.) %(0?..%F{red})%(!.#.$)%f '

precmd_functions+=(personal_prompt)
