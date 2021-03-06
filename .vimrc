" Include Arista-specific settings
if filereadable( "/usr/share/vim/vimfiles/arista.vim" )
   let a4_auto_edit=0
   source /usr/share/vim/vimfiles/arista.vim
   if has('nvim')
      set rtp+=/usr/share/vim/vimfiles/
   endif
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
Plug 'szw/vim-maximizer'
Plug 'hzchirs/vim-material'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'git@gitlab.aristanetworks.com:jeff/vim-alog.git'
Plug 'wesQ3/vim-windowswap'
call plug#end()

" Options for editing
set nocompatible
set shiftwidth=3
autocmd FileType python setlocal shiftwidth=3
set tabstop=3
set linebreak
set textwidth=85
set cindent
set expandtab
set nospell
set virtualedit=all
set history=5000
set fillchars+=vert:\ 
set number

" Enable mouse
set mouse=a

" Make splits appear as expected
set splitbelow
set splitright

" Prevent key pauses
set timeout
set timeoutlen=1000

" Options for setting the bottom 2 lines
set showmode

" Show non-printing characters
set list

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
set number

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
setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)
function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^\(diff\|---\|+++\|@@\) '
    return 1
 elseif line[0] =~ '[-+ ]'
    return 2
  else
    return 0
  endif
endfunction

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

filetype plugin on

" Mappings
let g:mapleader = "\<Space>"
map Y y$
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" ripgrep the word under the cursor
nnoremap <C-G> :Rg <C-R><C-W><cr>
" tnoremap <C-W> <Esc><Esc>:silent exec "!pkill rg"<cr>
" tab key mappings
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
map <C-n> :NERDTreeToggle<CR>
" Maximizer key mapping
nnoremap <silent><Leader>z :MaximizerToggle<cr>
nnoremap <C-W>z :MaximizerToggle<cr>

" Replace deleted text
vnoremap <C-X> <Esc>`.``gvP``P

" Terminal
if has( "nvim" )
 let g:terminal_scrollback_buffer_size=100000
    tnoremap <Esc><Esc> <C-\><C-n>
    endif

" Tagbar plugin
map <Leader>tb :call TagbarToggleLeft()<CR>
map <Leader>rb :call TagbarToggleRight()<CR>
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

function! TagbarToggleLeft (...)
   let g:tagbar_left = 1
   :TagbarToggle
endfunction

function! TagbarToggleRight (...)
   let g:tagbar_left = 0
   :TagbarToggle
endfunction

" Gitv plugin
let g:Gitv_DoNotMapCtrlKey = 1
nnoremap <silent> <Leader>gv :Gitv --branches --tags --remotes<cr>
nnoremap <silent> <Leader>gv! :Gitv!<cr>

" Airline plugin
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline_theme = "solarized"

" vim-fswitch plugin
let g:fsnonewfiles = 'on'
autocmd vimrc BufEnter *.*tin let b:fswitchdst = 'tac' | let b:fswitchlocs = './'
autocmd vimrc BufEnter *.tac let b:fswitchdst = 'tin,itin' | let b:fswitchlocs = './'
nmap <silent> <Leader>of :FSHere<cr>

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
map <Leader>ll :BLines<cr>
map <silent> <Leader>fh :Helptags<cr>
map <silent> <Leader>f: :History:<cr>
map <silent> <Leader>f/ :History/<cr>

" Color Modifications
" Fix for vertical line with hybrid theme
hi VertSplit term=reverse cterm=reverse guibg=Grey
