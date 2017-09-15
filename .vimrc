" Include Arista-specific settings
if filereadable( $VIM . "/vimfiles/arista.vim" )
   let a4_auto_edit=0
   source $VIM/vimfiles/arista.vim
endif

" Plugins via Vim-Plug
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'tmhedberg/matchit'
Plug 'vim-scripts/python_match.vim'
Plug 'saalaa/ancient-colors.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'haya14busa/vim-asterisk'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-hugefile'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/DirDiff.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-diff'
Plug 'derekwyatt/vim-fswitch'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'zw/vim-maximizer'
call plug#end()

" Options for editing
set nocompatible
set shiftwidth=3
set tabstop=3
set linebreak
set textwidth=85
set cindent
set expandtab
set nospell
set virtualedit=all
set history=5000


" Mouse support with tmux
set mouse=a
if &term =~ '^screen'
   "  tmux knows the extended mouse mode
   set ttymouse=xterm2
endif
 
" Make splits appear as expected
set splitbelow
set splitright

" Prevent key pauses
set timeout
set timeoutlen=1000

" Options for setting the bottom 2 lines
set showmode

set list

" UI stuff
"set background=dark
"colorscheme basic-dark

set nocursorline
set visualbell
set ignorecase
set smartcase
set guioptions=aeir
set hidden
set hlsearch
set incsearch
set showcmd
set lazyredraw
set tags=tags;/
set path=**

" UI stuff
set background=light
function! SetColours()
   try
      colorscheme solarized
   catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme desert
   endtry
endfunction
call SetColours()

" Highlight cursor line only in current window
augroup CulHighlight
   autocmd!
   autocmd WinEnter * set cul
   autocmd WinLeave * set nocul
augroup END

if has("gui_running")
  if has("gui_win32")
    set guifont=Lucida_Console:h10:cDEFAULT
  endif
endif

" Options for folding
set foldmethod=indent           "fdm:   fold by the indentation by default
set nofoldenable                "nofen: don't fold by default

" Options for backup files
set nobackup
set nowritebackup
if has('unix')
   set directory=/tmp
else
   set directory=$TEMP
endif

" define a group `vimrc` and initialize.
augroup vimrc
   autocmd!
augroup END

" Options for vimdiff
set diffopt=filler,vertical
" Automatically diffupdate on write
autocmd vimrc BufWritePost * if &diff == 1 | diffupdate | endif

" Always move some windows to the bottom
autocmd vimrc FileType qf wincmd J
autocmd vimrc FileType gitcommit wincmd J

" Treat *.md files as markdown instead of Modula-2
autocmd vimrc BufNewFile,BufReadPost *.md set filetype=markdown
autocmd vimrc BufNewFile,BufReadPost *.md set textwidth=0

" Special textwidth gitcommit
autocmd vimrc FileType gitcommit setlocal textwidth=72

" Treat *.*tin files as C++
autocmd vimrc BufNewFile,BufReadPost *.*tin set filetype=cpp

" Mappings
let g:mapleader = "\<Space>"
map Y y$
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" ripgrep the word under the cursor
nnoremap <C-G> :Rg <C-R><C-W><cr>
nnoremap <silent><Leader>tc :tabclose<return>
nnoremap <silent><Leader>tn :tabnew<return>
nnoremap <Leader>te :tabedit<space>
nnoremap <Leader>tm :tabmove<space>
nnoremap <silent><Leader>co :copen<return>
nnoremap <silent><Leader>cc :cclose<return>
nnoremap <silent><Leader>\| :vsp<cr>
nnoremap <silent><Leader>- :sp<cr>
" Press Space to turn off highlighting and clear any message already displayed.
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <silent><Leader>C :call SetColours()<cr> "Fix colors when they get messed
nnoremap <silent><Leader>tt :terminal<cr>
nnoremap <silent><Leader>e :Explore<cr>
" Maximizer key mapping
nnoremap <silent><Leader>z :MaximizerToggle<cr>
nnoremap <C-W>z :MaximizerToggle<cr>

" Terminal
if has( "nvim" )
 let g:terminal_scrollback_buffer_size=100000
    tnoremap <Esc><Esc> <C-\><C-n>
    endif



" Tagbar plugin
map <Leader>tb :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_left = 1
let g:tagbar_type_tac = {
   \ 'ctagstype' : 'tacc',
   \ 'kinds'     : [
       \ 'd:definition'
   \ ],
   \ 'sort'    : 0
\ }

" Gitv plugin
let g:Gitv_DoNotMapCtrlKey = 1
nnoremap <silent> <Leader>gv :Gitv --branches --tags --remotes<cr>
nnoremap <silent> <Leader>gv! :Gitv!<cr>

" Fugitive plugin
map <silent> <Leader>gs :Gstatus<cr>
map <Leader>ge :Gedit<space>
map <Leader>gd :Gdiff<space>
map <Leader>gc :Gcommit<space>
map <silent> <Leader>gb :Gblame<cr>

" Fzf
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --vimgrep --type-add "ar:*.{tac,tin,py,ar,am}" --type-add "tac:*.tac" --type-add "tin:*.tin" --no-ignore --color=always '.<q-args>, 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%:hidden', '?'),
\   <bang>0)

map <silent> <Leader>ff :Files<cr>
map <silent> <Leader>bf :Buffers<cr>
map <silent> <Leader>bd :bd<cr>
map <silent> <Leader>t :BTags<cr>
map <silent> <Leader>T :Tags<cr>
map <silent> <Leader>m :Marks<cr>
map <Leader>g :Rg<space>
map <Leader>l :BLines<cr>
map <silent> <Leader>fh :Helptags<cr>
map <silent> <Leader>f: :History:<cr>
map <silent> <Leader>f/ :History/<cr>

