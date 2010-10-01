set nocompatible

" ****************
" Script section *
" ****************

" *********************
" Status line section *
" *********************

set statusline=%t\              "tail of the filename
set statusline+=%y              "filetype
set number
"display a warning if file encoding isn't utf-8
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%r              "read only flag
set statusline+=%m              "modified flag

set statusline+=%=              "left/right separator
set statusline+=col:%c\         "cursor column
set statusline+=line:%l/%L\     "cursor line
set statusline+=%P              "percent through file
set laststatus=2


"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction


" *********************
" OS specific section *
" *********************

if has("gui_running")
    colorscheme candycode       " other nice colorschemes to try: molokai, fruity
    set cursorline              " Highlight current line
else
    syntax off
end

if has("gui_gtk2")
    set guifont=Monospace\ 11
    let cfgfile = ".vimrc"
    let mapleader = ";"
elseif has("gui_win32")
    set guifont=Inconsolata:h12,Dejavu\ Sans\ Mono:h13,Consolas:h12
    let cfgfile = "_vimrc"
    let mapleader = ";"
elseif has("mac")
    set macmeta
    set guifont=Menlo:h16
    let cfgfile = ".vimrc"
    let mapleader = ";"
else
    let cfgfile = ".vimrc"
    let mapleader = ";"
end

" ****************
" Config section *
" ****************

" Calling pathogen that manages bundle plugins folder
" obs: pathogen needs to reload filetype settings in order
"      to load ftplugins correctly
filetype off
call pathogen#runtime_append_all_bundles() 
filetype plugin indent on

if has("autocmd")
    au BufRead,BufNewFile *.js set ft=javascript.jquery
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType java set omnifunc=javacomplete#Complete
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd GUIEnter * set lines=40 columns=150
endif

" AutoComplPop configuration
let g:acp_behaviorKeywordLength = 4
let g:acp_enableAtStartup = 1
let g:acp_completeoptPreview = 1

" NERDTree configuration
let g:NERDTreeShowBookmarks=1

" Command-T configuration
let g:CommandTMatchWindowAtTop=1

syntax on
set wildignore+=*.bak,*.pyc,*.py~,*.pdf,*.so,*.gif,*.jpg,*.flv,*.class,*.jar,*.png,*/tools/*,*/docs/*,*.swp
set wildmode=list:longest
set wildmenu
set anti
set textwidth=0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set expandtab
set backspace=indent,eol,start
set smarttab
set smartindent
set showmode
set showcmd
set fileformats=unix,dos
set showmatch       " Show matching brackets.
set autowrite       " Automatically save before commands like :next and :make
set wmh=0           " set winminheight to 0
set ruler
set linebreak
set guioptions-=T   " Turn toolbar off
set guioptions-=m   " Turn menubar off
set guioptions-=r   " remove right-hand scroll bar
set virtualedit=all
set smartcase       " Do smart case matching
set mousemodel=popup
set foldmethod=indent 
set foldlevel=999
set guitablabel=%N\ %t\ %M
set undofile
set modelines=0
set visualbell
set cursorline
set ttyfast
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"salva quando perde foco
"au FocusLost * :wa

compiler ruby
" *****************
" Mapping section *                    
" *****************


"desativar setas... 
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk



map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>
vmap <C-y> "+y
vmap <silent><C-s> :sort<CR>
nmap <C-s> :w<CR>
imap <silent><C-s> <ESC>:w<CR>a
imap <silent><C-Del> <ESC>dea
inoremap <C-k> <ESC>
"inoremap <CR> <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <space> za
map <leader>a <ESC>ggvG$
nnoremap <silent><leader>f :CommandT<CR>

" Maps for tab specific funcionalities
nnoremap L :tabnext<CR>
nnoremap H :tabprevious<CR>
map <M-t> :tabnew<CR>
nmap <silent><leader>n :tabnew<CR>

" Remap code completion to Ctrl-Space
inoremap <C-Space> <C-x><C-u>
inoremap <C-j> <C-n>

" Rails specific mappings
inoremap <M-=> <%=  %><ESC>hhi
inoremap <M--> <%  -%><ESC>hhhi
nnoremap gr  :R<CR>
nnoremap grt :RT<CR>
nnoremap ga  :A<CR>
nnoremap gat :AT<CR>

" Automatically surround brackets, quotes, double quotes, etc..
inoremap '<space> ''<ESC>i
inoremap "<space> ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i

nnoremap <silent><leader>q :NERDTreeToggle<CR>
nnoremap <silent><leader>s :set spell spelllang=pt<CR>
exec "nmap <leader>r :source ~/".cfgfile." <CR>:echo 'Refresh!' <CR>"

nnoremap - :q<CR>
nnoremap <C-_> :q!<CR>

map <silent><leader>c <plug>NERDCommenterToggle
map <silent><leader>x <plug>NERDCommenterSexy
map <silent><leader>z <plug>NERDCommenterMinimal

"Search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"Identa o arquivo
nnoremap <leader>K gg=G 
