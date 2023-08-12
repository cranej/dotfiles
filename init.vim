set nocompatible
let mapleader =","
let g:mapleader = ","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  echo "Fuck the Chinese big brother, raw.githubusercontent is blocked... git clone instead..."
  silent !git clone --depth 1 https://github.com/junegunn/vim-plug.git /tmp/vim-plug
  silent !cp /tmp/vim-plug/plug.vim ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  silent !rm -r /tmp/vim-plug
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'ap/vim-css-color'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/vim-expand-region'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-latex/vim-latex'
call plug#end()

autocmd BufReadPost fugitive://* set bufhidden=delete
"vim-markdown YAML support
let g:vim_markdown_frontmatter = 1
"vim-better-whitespace
let g:better_whitespace_enabled = 0
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
"ctrlp.vim
let g:ctrlp_types = ['fil', 'buf']

call expand_region#custom_text_objects({
      \'i}'  :1,
      \'a}'  :1,
      \})

set t_Co=256
set cc=80
set nowrap
set notimeout
set showcmd
set autoread
set nomodeline
set splitbelow splitright
set title
set clipboard+=unnamedplus
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set number
set wildmode=longest,list,full
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set showcmd
" No annoying sound on errors
" This is kind of tricky for me. Refer: http://vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
" Add a bit extra margin to the left
set nofoldenable
set background=dark
set nobackup
set nowb
set noswapfile
set noundofile
set viminfo=
set ai "Auto indent
set si "Smart indent
set tabstop=4
set shiftwidth=0

filetype plugin on
syntax on

noremap j gj
noremap k gk
" Close all the buffers
noremap <leader>ba :1,1000 bd!<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr><cr>
noremap ]t :tabnext<CR>
noremap [t :tabprevious<CR>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fast saving
nnoremap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" Delete to hole
nnoremap D "_d
vnoremap D "_d

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ %{fugitive#statusline()}\ %Y\ \ CWD:\ %{getcwd()}%14.(%l,%c%V%)\ \ %P

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

noremap <silent> <leader><cr> :noh<cr>
noremap <space> /
noremap <leader><space> ?
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Move a line of text using <leader>[jk]
nnoremap <leader>j mz:m+<cr>`z
nnoremap <leader>k mz:m-2<cr>`z
vnoremap <leader>j :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <leader>k :m'<-2<cr>`>my`<mzgv`yo`z

" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>

" Toggle readonly
nnoremap <leader>tr :set readonly!<cr>

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace ex mode with gq
map Q gq

" Check file in shellcheck:
map <leader>s :!clear && shellcheck -x %<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>

" Terminal mode
tnoremap <Esc> <C-\><C-n>

" Turns off highlighting on the bits of code that are changed,
" so the line that is changed is highlighted but the actual text that has
" changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" ripgrep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

"vim-latex
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf="zathura"
let g:Tex_CompileRule_pdf='xelatex $*'
let g:Tex_CustomTemplateDirectory="$HOME/tex-template/"

autocmd VimLeave *.tex !texclear %
autocmd BufRead,BufNewFile *.tex setlocal shiftwidth=2

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set cc=
        set nonumber
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set cc=80
        set number
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

highlight Normal ctermfg=none ctermbg=none
highlight NonText ctermfg=none ctermbg=none
highlight EndOfBuffer ctermfg=none ctermbg=none
highlight TabLineFill ctermfg=none ctermbg=none
highlight Search ctermbg=12
highlight NonText ctermfg=darkgrey
highlight SpecialKey ctermfg=darkgrey
highlight clear SignColumn
highlight Comment cterm=bold ctermfg=none
highlight StatusLine cterm=none ctermbg=none ctermfg=darkgrey
highlight StatusLineNC cterm=none ctermbg=none ctermfg=darkgrey
highlight Title cterm=none ctermfg=darkgrey
highlight TabLineFill cterm=none
highlight TabLine cterm=none ctermfg=darkgrey ctermbg=none
highlight ColorColumn ctermbg=darkgrey guibg=lightgrey
highlight Todo ctermbg=NONE ctermfg=red cterm=bold
highlight PreProc ctermfg=grey
highlight String ctermfg=darkblue cterm=italic
highlight Type ctermfg=darkblue
highlight lineNr ctermfg=grey cterm=italic
highlight cIncluded ctermfg=NONE cterm=bold
highlight pythonInclude ctermfg=blue
highlight pythonConditional ctermfg=darkcyan
highlight pythonBuiltin ctermfg=darkcyan
highlight Pmenu ctermbg=white ctermfg=black
highlight PmenuSel ctermbg=darkcyan ctermfg=black
highlight SpellBad cterm=standout ctermbg=none ctermfg=red
highlight SpellCap cterm=bold ctermbg=none ctermfg=darkyellow
highlight SpellRare cterm=bold ctermbg=none ctermfg=lightred
highlight SpellLocal cterm=standout ctermbg=none ctermfg=lightyellow

autocmd BufRead,BufNewFile *.md,*.markdown setlocal wrap cc=
autocmd BufRead,BufNewFile *.txt,*.gmi setlocal wrap cc=

nnoremap <leader>rc :!cargo check<CR>
nnoremap <leader>rb :!cargo build<CR>

