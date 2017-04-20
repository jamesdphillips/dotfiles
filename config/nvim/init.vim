"
" Plugins

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Go
Plug 'fatih/vim-go'

" Go Code
Plug 'nsf/gocode'

" Control-P
Plug 'kien/ctrlp.vim'

" T-Comment
Plug 'tomtom/tcomment_vim'

" Additional colour schemes
Plug 'flazz/vim-colorschemes'

" 
Plug 'tweekmonster/gofmt.vim'

" Initialize plugin system
call plug#end()

"
" Key mappings

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

"
" Style

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Color scheme
colorscheme molokai
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

augroup vimrcEx
  autocmd!

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
augroup END

"
" Go

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim             " Official linter
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow " Run linter on save

let g:go_fmt_command = "goimports"
