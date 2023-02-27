--Typescript server does not support autocomplete functions by default. We have to do it manually.
--Check issue: https://www.reddit.com/r/neovim/comments/vdc7uo/enabling_function_call_snippets_with/

return {
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
}
