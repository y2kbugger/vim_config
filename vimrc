"setup for Vundle, the plugin manager
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'mbbill/undotree'
Plugin 'chrisbra/Recover.vim'
Plugin 'tpope/vim-commentary'
Plugin 'lervag/vimtex'
Plugin 'ervandew/supertab'
call vundle#end()
filetype plugin indent on    " required
"===============================================

" enable syntax highlighting
syntax enable

" allow bright colors without bold colors
set t_Co=16
set background=dark
colorscheme solarized

" only use the mouse for moving the cursor and scrolling
" don't let in start highlighting things
set mouse=n
" don't register mouse single clicks
noremap <LeftMouse> <nop>
noremap <RightMouse> <nop>

nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader='\'

" force line wraps to have a hanging indent
set breakindent
set breakindentopt=min:20,shift:2
" break only on certain characters (such as spaces)
set linebreak

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set list
" Use the symbols for tab and EOL
set listchars=tab:>»,eol:¬
" fixes issue where colors are rendered incorrectly because of bold/italics
let g:solarized_italic=0
let g:solarized_bold=0
" make whitespace and special keys like tab invisible except when on top of them
let g:solarized_visibility="low"

" print all 16 term colors on each of the 4 solarized backgrounds
command! VimColorTest call VimColorTest('vim-color-test.tmp')
function! VimColorTest(outfile)
  let result = []
    for bg in [0,8,7,15]
    for fg in range(0,15)
        let kw = printf('%-7s', printf('c_%d_%d', fg, bg))
        let h = printf('hi %s ctermfg=%d ctermbg=%d', kw, fg, bg)
        let s = printf('syn keyword %s %s', kw, kw)
        call add(result, printf('%-32s | %s', h, s))
     endfor
     call add(result, '')
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction

" show line numbers
set number

set splitbelow
set splitright

" set foldmethod=marker

" force jk mapping for normal mode
inoremap jk <esc>
" inoremap <esc> <nop> "disabled because it caused issues with any key that included esc sequences

" dont let arrow keys be used at all
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>

" link X primary with the default register
set clipboard=unnamed

" auto wrap git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically run a file
nnoremap <F5> :w<Enter>:!%:p<Enter>

" set up tabstops and converting tabs to spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" enable partial matching as I type
set incsearch
" enable highlighting on searches
set hlsearch

" increase the memorized commands in vim, also increases ctrlp history
set history=1000

" stuff for ctrlp (fuzzy searching for opening files)
let g:ctrlp_show_hidden = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|Android|vids|musik|pics|oldhome|AndroidStudio|\.gradle|\.cache|eclipse4\.3\.1)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" cache across sessions
let g:ctrlp_clear_cache_on_exit = 0
" make it taller
let g:ctrlp_max_height = 20
" recent files to remember
let g:ctrlp_mruf_max = 2500
"
let g:ctrlp_mruf_exclude = '/tmp/.*\|\.vifm/.*\|/usr/share' 
" disable MRU mode sorting
" let g:ctrlp_mruf_default_order = 1
let g:ctrlp_map = '<leader>m'
let g:ctrlp_cmd = 'CtrlPMRUFiles'
noremap <leader><leader>m :tabnew<CR>:CtrlPMRUFiles expand('%:p:h')<CR>
noremap <leader>n :CtrlPClearCache<CR>:CtrlP expand('%:p:h')<CR>
noremap <leader><leader>n :tabnew<CR>:CtrlPClearCache<CR>:CtrlP expand('%:p:h')<CR>

" enable per-directory .vimrc files
set exrc           
set secure " disable unsafe commands in local .vimrc files

" sensible settings for put
"nnoremap p P
"nnoremap P p

" my personal dictionary
set spell
set spellfile=/home/y2k/.vim/spell/y2k.utf-8.add

" Allow saving of files as sudo when I forgot to start vim using sudo.
command W w !sudo tee > /dev/null %

" allow deleting and changing without killing my default buffer
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
nmap <silent> <leader>c "_c
vmap <silent> <leader>c "_c

" we all know this trick, unsure of whether it will stick
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
" and now a fix for the command-line buffer
nnoremap q; q:
vnoremap q; q:
" quickly open the command-line buffer from command mode
" this is much more useful than the q: about
cnoremap jk <C-F> 

" make mapping for Y act the same way as D and C
nmap Y y$

" persist undos across vim instances
set undofile 
set undodir=~/.vim/undodir,.
set undolevels=5000
set undoreload=50000

" configure the graphical undo tree
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1

" when removing all inserted chars from the current line,
" break the undo sequence and start a new change
inoremap <C-U> <C-G>u<C-U>

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" enable the bashlike commandline completion
set wildmenu
set wildmode=longest,list

" better completion in insert mode
set completeopt=longest,menuone
" all continuing to type to narrow and then Enter to select
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :'<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"easier omnicompletion
set omnifunc=syntaxcomplete#Complete
"for some reason C-@ is space in terminals
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>


"when editing tex us mupdf as the viewer
let g:vimtex_view_method = 'mupdf'

" y2ks autocommands 
au FileType tex setl sw=2 sts=2 et
au FileType awk set commentstring=#\ %s

" nav on display lines rather than physical lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
