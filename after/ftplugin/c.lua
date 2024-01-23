vim.g.user42 = 'ledos-sa'
vim.g.mail42 = 'ledos-sa@student.42.fr'

vim.g.syntastic_c_checkers = {'norminette'}
vim.g.syntastic_aggregate_errors = 1
vim.g.syntastic_c_norminette_exec = 'norminette'
vim.g.c_syntax_for_h = 1
vim.g.syntastic_c_include_dirs = {'include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include'}
vim.g.syntastic_c_norminette_args = '-R CheckTopCommentHeader'
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 0
vim.g.syntastic_check_on_wq = 0
