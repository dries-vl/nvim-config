-- TREESITTER SETUP
require'nvim-treesitter.configs'.setup{
  	ensure_installed = { "c", "lua", "rust", "markdown", "markdown_inline" },
	ignore_install = { "all" },
	additional_vim_regex_highlighting = false,
	highlight={enable=true}
}



