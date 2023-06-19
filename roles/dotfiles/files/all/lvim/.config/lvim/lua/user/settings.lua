vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd([[set nofen]])

local default_options = {
	backup = false, -- creates a backup file
	-- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	clipboard = "", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" },
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	guifont = "monospace:h17", -- the font used in graphical neovim applications
	hidden = true, -- required to keep multiple buffers and open multiple buffers
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	-- timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
	title = true, -- set the title of window to the value of the titlestring
	-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
	undofile = true, -- enable persistent undo
	updatetime = 100, -- faster completion
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	shadafile = join_paths(get_cache_dir(), "lvim.shada"),
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
	sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
	showcmd = false,
	ruler = false,
	laststatus = 3,
	-- folding tree sitter based
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	formatoptions = {
		["1"] = true,
		["2"] = true, -- Use indent from 2nd line of a paragraph
		q = true, -- continue comments with gq"
		c = true, -- Auto-wrap comments using textwidth
		r = true, -- Continue comments when pressing Enter
		n = true, -- Recognize numbered lists
		t = false, -- autowrap lines using text width value
		j = true, -- remove a comment leader when joining lines.
		-- Only break if the line was not longer than 'textwidth' when the insert
		-- started and only at a white character that has been entered during the
		-- current insert command.
		l = true,
		v = true,
	},
	wildignore = {
		"*.aux,*.out,*.toc",
		"*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
		-- media
		"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
		"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
		"*.eot,*.otf,*.ttf,*.woff",
		"*.doc,*.pdf",
		-- archives
		"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
		-- temp/system
		"*.*~,*~ ",
		"*.swp,.lock,.DS_Store,._*,tags.lock",
		-- version control
		".git,.svn",
	},
	ttimeoutlen = 10,
	wrapscan = true, -- Searches wrap around the end of the file
	pumblend = 10,
	joinspaces = false,
	confirm = true, -- make vim prompt me to save before doing destructive things
	autowriteall = true, -- automatically :write before running commands and changing files
	shortmess = {
		t = true, -- truncate file messages at start
		A = true, -- ignore annoying swap file messages
		o = true, -- file-read message overwrites previous
		O = true, -- file-read message overwrites previous
		T = true, -- truncate non-file messages in middle
		f = true, -- (file x of x) instead of just (x of x
		F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
		s = true,
		c = true,
		W = true, -- Don't show [w] or written when writing
	},
}

for k, v in pairs(default_options) do
	vim.opt[k] = v
end

vim.wo.foldlevel = 4
vim.wo.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

local disabled_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- focus-based relative lines
vim.cmd([[augroup numbertoggle]])
vim.cmd([[  autocmd!]])
vim.cmd([[  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif]])
vim.cmd([[  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif]])
vim.cmd([[augroup END]])

pcall(require, "profile")
