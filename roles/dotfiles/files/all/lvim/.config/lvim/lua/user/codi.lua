local M = {}

M.config = function()
	vim.cmd([[
    let g:codi#interpreters = {
    \ 'python': {
        \ 'bin': 'python',
        \ 'prompt': '^\(>>>\|\.\.\.\) ',
        \ },
    \ }
  ]])
end

return M
