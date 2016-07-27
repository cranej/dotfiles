" => Plugin {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Shougo/vimproc'
Plugin 'Align'
Plugin 'tpope/vim-surround'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'qpkorr/vim-renamer'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'PProvost/vim-ps1'
Plugin 'altercation/vim-colors-solarized'
Plugin 'unblevable/quick-scope'
Plugin 'vim-scripts/Tagbar'
Plugin 'fholgado/minibufexpl.vim'
call vundle#end()

filetype plugin indent on

noremap <C-t> :NERDTreeToggle<CR><CR>
let NERDTreeIgnore=[
    \ ".*\\.class$",
    \ ".*\\.o$",
    \ ".*\\.hi$",
    \ ".*\\.cmi$",
    \ ".*\\.cmx$",
    \ ".*\\.exe$",
    \ ]

"fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

"vim-markdown YAML support
let g:vim_markdown_frontmatter = 1
"}}}
" => General {{{

autocmd BufReadPost *vimrc setlocal foldmethod=marker

set encoding=utf-8
set nocompatible
" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread
" Write automatically before running command
set autowrite
" One space instead of two after punctuation
set nojoinspaces
" no modeline
set nomodeline

set splitbelow
set splitright
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
" Map , to \
nnoremap \ ,

" Fast saving
nnoremap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Delete to hole
nnoremap D "_d
vnoremap D "_d
"}}}
" => Windows specified stuff {{{

" :Psh launch powershell, :Psh args run args in powershell
if has("win32") || has("win16")
    function! RunPowershell(...)
        let l:argLength = len(a:000)
        if l:argLength == 0
            execute "!powershell"
        else
            let psargs = join(a:000," ")
            execute "!powershell -Command ".psargs
        endif
    endfunction
    command! -nargs=* Psh :call RunPowershell(<f-args>)

    " :Fsi start a fsharp interective console, and load current file into it
    command! -nargs=0 Fsi !fsi --load:%

    " make binaries from ~/vimfiles/bin take preference
    let $PATH=expand("~")."/bin/gnubin;".$PATH
    set grepprg=grep.exe\ -niIH
endif

" }}}
" => VIM user interface {{{

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

"Always show line number
set number

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch
" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

"search
noremap <space> /
noremap <leader><space> ?

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
set showcmd
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
" This is kind of tricky for me. Refer: http://vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set tm=1000
set ttimeoutlen=50

" Add a bit extra margin to the left
set foldcolumn=1
set nofoldenable
" }}}
" => Colors and Fonts {{{

" Enable syntax highlighting
syntax enable

set background=light
let g:solarized_termcolors=256
colorscheme solarized

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=c
    set guioptions-=e
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    set guicursor=a:blinkon700
    set t_Co=256
    set guitablabel=%M\ %t
    set lines=40
    set columns=120
    if has("mac") || has("maxunix")
        set guifont=Monaco:h12
      elseif has("win32") || has("win16")
        set guifont=Consolas:h11,Courier\ New:h10
    endif
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" }}}
" => Files, backups and undo {{{

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"Turn off viminfo and persistent undo file for security reason
set noundofile
set viminfo=

" }}}
" => Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" }}}
" => Visual mode related {{{

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

" }}}
" => Moving around, tabs, windows and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Close the current buffer
noremap <leader>bd :Bclose<cr>

" Close all the buffers
noremap <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr><cr>
noremap ]t :tabnext<CR>
noremap [t :tabprevious<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab

" }}}
" => Status line {{{

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ %{fugitive#statusline()}\ %Y\ \ CWD:\ %{getcwd()}%14.(%l,%c%V%)\ \ %P


" }}}
" => Editing mappings {{{

" Remap VIM 0 to first non-blank character
noremap 0 ^

" Move a line of text using <leader>[jk]
nnoremap <leader>j mz:m+<cr>`z
nnoremap <leader>k mz:m-2<cr>`z
vnoremap <leader>j :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <leader>k :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" quit window
nnoremap K :q<cr>
nnoremap M K
"save
nnoremap s :w<cr>

" Substitute
nnoremap ss :%s/
vnoremap ss :s/
" }}}
" => Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s= z=

" }}}
" => Markdown {{{
au BufRead,BufNewFile *.md,*.markdown set filetype=markdown
au FileType markdown call MarkdownHook()

function MarkdownHook()
    set conceallevel=2
    syn match itemCompleteMark "^\s*\zs\(\d\+\.\|*\|\.\|-\)\s\s*\[x]" conceal cchar=√
    syn match inProgressMark "^\s*\zs\(\d\+\.\|*\|\.\|-\)\s\s*\[ ]" conceal cchar=□
endfunction

let g:markdown_cmd = "pandoc"
let g:start_cmd = "open" "for mac osx use open
if has("win32") || has("win16")
    let g:start_cmd = "start"
elseif has("unix")
    let s:os = substitute(system('uname'), "\n", "", "")
    if s:os!= "Darwin"
        "for linux use sesible-browser
        let g:start_cmd = "sensible-browser"
    endif
endif

function! MarkdownPreview()
    let l:preview_file = tempname() . ".html"
    execute "w"
    execute "!" . g:markdown_cmd . " -o " . l:preview_file . " " . bufname("%") . " && " . g:start_cmd . " " . l:preview_file
    redraw
endfunction

function! ConvertMarkdown(...)
    let l:cwd = getcwd()
    let l:to = "html"
    let l:from = "markdown_github-hard_line_breaks+pandoc_title_block"
    let l:folder = expand("%:p:h") . "/generated"
    if a:0 > 0
        let l:to = a:1
    endif
    if a:0 > 1
        let l:folder = a:2
    endif
    let l:output = l:folder . "/" . expand("%:t:r") . "." . l:to
    execute "silent w"
    :lcd %:p:h
    execute "!" . g:markdown_cmd . " -t " . l:to . " -f " . l:from . " -o " . l:output . " " . expand("%")
    redraw
    execute "cd " . l:cwd
endfunction

command! -nargs=* ConvertMd :call ConvertMarkdown(<f-args>)
noremap <leader>mp :call MarkdownPreview()<CR>
" }}}
" => Haskell  {{{
autocmd FileType haskell call HaskellHook()
autocmd BufRead,BufNewFile *.lhs call HaskellHook()
autocmd BufRead,BufNewFile *.hs,*.hsc,*.purs set filetype=haskell
function HaskellHook()
    noremap <C-i> :!ghci -Wall "%:p"<CR>
    noremap <C-c> :%!stylish-haskell<CR>
    noremap <C-g>t :GhcModType<CR>
    noremap <C-g><C-t> :GhcModType<CR>
    noremap <C-g>i :GhcModInfo<CR>
    noremap <C-g><C-i> :GhcModInfo<CR>
    noremap <C-g>p :GhcModInfoPreview<CR>
    noremap <C-g><C-p> :GhcModInfoPreview<CR>
    noremap <C-g>c :GhcModTypeClear<CR>
    noremap <C-g><C-c> :GhcModTypeClear<CR>
    setlocal makeprg=stack\ build
endfunction

" }}}
" => Javascript  {{{
au BufRead,BufNewFile *.json set filetype=javascript
au BufRead,BufNewFile *.json nnoremap <C-c> :%!aeson-pretty<CR>

" }}}
" => Xml  {{{
au FileType xml nnoremap <C-c> :%!xmllint --format -<CR>

"}}}
" => Chinese Input method issue {{{
set noimdisable
autocmd! InsertLeave * set imdisable
autocmd! InsertEnter * set noimdisable

" }}}
" => Misc {{{

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Use unnamed clipboard to paste and copy directly
set clipboard=unnamed

" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>

"Grep
command! -nargs=+ -complete=file Grep :silent grep! <args> | copen
command! -nargs=+ -complete=file GrepNoise :grep! <args> | copen

"Encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

"Invisible chars
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>l :set list!<CR>
" }}}
" => Abbrevations  {{{
iabbrev cj@ crane@cranejin.com
iabbrev cjo@ crane.jin@outlook.com

" }}}
" => Helper functions {{{
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

"Copy all matches after a search - Super useful!
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
"}}}
" => Vim debugging helpers {{{
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
