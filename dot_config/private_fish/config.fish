if status is-interactive
	eval (zellij setup --generate-auto-start fish | string collect)
end


set fzf_configure_bindings --directory\cf --variables=\e\cv
set fzf_configure_bindings --git_status=\cg --history=\ch --variables= --processes=
set fzf_preview_dir_cmd exa --all --color=always`
