# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>

PROMPT=" %F{blue}%3~%f %(1j.%F{yellow}*%f .)%(0?..%F{red})%(!.#.$)%f "
RPROMPT=

function personal_prompt_async () {
	2>&1 git -C "$1" --no-optional-locks status --branch --porcelain=v2 | awk -f $XDG_CONFIG_HOME/zsh/gitprompt.awk
}
function personal_prompt_callback () {
	RPROMPT="$3"
	zle reset-prompt
}
function personal_prompt () {
	>/dev/null 2>&1 command -v async_init || return
	async_flush_jobs personal_prompt_worker
	while ! {2>/dev/null async_job personal_prompt_worker personal_prompt_async $PWD}; do
		async_start_worker personal_prompt_worker
		async_register_callback personal_prompt_worker personal_prompt_callback
	done
}

precmd_functions+=(personal_prompt)
