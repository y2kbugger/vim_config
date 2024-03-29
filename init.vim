runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"
"##################
" General Settings
"##################

" force in python path on windows
if has('win32')
    let g:python3_host_prog='C:\ProgramData\CooperConda\pythonw.exe'
endif

" enable syntax highlighting
syntax enable
" enable commentstring and indention awareness
filetype plugin indent on

" allow bright colors without bold colors
set t_Co=16
set background=dark

colorscheme solarized

" fixes issue where colors are rendered incorrectly because of bold/italics
let g:solarized_italic=0
let g:solarized_bold=0
" make whitespace and special keys like tab invisible except when on top of them
let g:solarized_visibility="low"

" do not store global and local values in a session
set ssop-=options

" allow more backspacing
set backspace=indent,eol,start

set ignorecase
set smartcase

" break only on certain characters (such as spaces)
set linebreak
" Delete comment character when joining commented lines
set formatoptions+=j
" force line wraps to have a hanging indent
set breakindent
set breakindentopt=min:20,shift:2

" allow nonsaved buffers to be hidden
set hidden

" enable the bashlike commandline completion
set wildmenu
set wildmode=longest:list,full

" Use the symbols for tab and EOL
"set listchars=tab:»·,eol:¬ " from windows. shows invisible on diff on linux...hmm
set listchars=tab:»·,eol:¬
set list

" show line numbers
set number

set splitbelow
set splitright

" set foldmethod=marker

" link X secondary with the default register
" This leaves X primary for highlight type copy
set clipboard=unnamedplus

" set up tabstops and converting tabs to spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" enable partial matching as I type
set incsearch
" enable highlighting on searches
set hlsearch

" increase the memorized commands in vim, also increases ctrlp history
set history=1000

" enable per-directory .vimrc files
set exrc

" disable unsafe commands in local .vimrc files
set secure

" my personal dictionary
set spell
set spellfile=~/.config/nvim/spell/en.utf-8.add

" keep cursor away from the edge
set scrolloff=15

" always make the current directory your working directory
" set autochdir
" trying to use vim rooter for this

"set the wrapping text width
"set textwidth=64

" don't search included files in autocomplete
setglobal complete-=i

" persist undos across vim instances
" Vim will detect if an undo file is no longer synchronized with the file it was
" written for (with a hash of the file contents) and ignore it when the file was
" changed after the undo file was written, to prevent corruption.
set undofile
" set undodir=~/vim/undodir,~/vimfiles/undodir,.
set undolevels=500
set undoreload=10000


"#########
" Mapping
"#########

" Simple
"--------
" <SPACE> as the my leader (talk to him)
nnoremap <SPACE> <Nop>
let mapleader=" "
" jk mapping for normal mode
inoremap jk <esc>
" quickly open the command-line buffer from command mode
cnoremap jk <C-F>

" only use the mouse for moving the cursor and scrolling
" don't let in start highlighting things
set mouse=n
" don't register mouse single clicks
noremap <LeftMouse> <nop>
noremap <RightMouse> <nop>

" make mapping for Y act the same way as D and C
nmap Y y$

" allow deleting and changing without killing my default buffer
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
nmap <silent> <leader>c "_c
vmap <silent> <leader>c "_c

" nav on display lines rather than physical lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
"noremap  <buffer> <silent> 0 g0
"noremap  <buffer> <silent> $ g$

" when diffing a large amount, this makes it quicker
nmap <Right> dp]c
nmap <Up> [c
nmap <Down> ]c


" Handicaps
"-----------
" dont let arrow keys be used at all
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
" also be a real man(for now till I learn more)
nnoremap h <NOP>
vnoremap h <NOP>
" noremap j <NOP>
" noremap k <NOP>
nnoremap l <NOP>
vnoremap l <NOP>

"Macroishes
"-----------
" Allow saving of files as sudo when I forgot to start vim using sudo.
command W w !sudo tee > /dev/null %
" from visual mode start a search and replace
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

" when removing all inserted chars from the current line,
" break the undo sequence and start a new change
inoremap <C-U> <C-G>u<C-U>

" scheme
au BufReadPost *.rkt,*.rktl
 \ set filetype=scheme

au FileType tex
 \ setl sw=2 sts=2 et

"  Fix  last typing mistake from insert and normal mode
imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-l> i<c-g>u<Esc>[s1z=`]

" :terminal
" when you are in :terminal allow <c-w> to get you all of the way out
" https://www.reddit.com/r/neovim/comments/6kf7vh/i_have_been_doing_everything_inside_of_neovims/
tnoremap <C-w> <C-\><C-n><C-w>
au TermOpen,BufWinEnter,WinEnter term://* startinsert

" automatically run a file
nnoremap <F5> :update<Bar>terminal%<CR>
au Filetype c,cpp
 \ nnoremap <buffer> <F5> :wa<Bar>:!touch %<Bar>make<CR>
au Filetype python
 \ nnoremap <buffer> <F5> :wa<Bar>terminal python %<CR>
au Filetype java
 \ nnoremap <buffer> <F5> :wa<Bar>execute javac %<CR>
au Filetype mmix nnoremap <buffer> <F5> :wa<Bar>split term://mmixal % && mmix -t2 -l -L %:r.mmo<CR>
" au FileType mmix call deoplete#custom#buffer_option('auto_complete', v:false)
au FileType mmix set noet ci pi sts=0 sw=16 ts=16
au BufReadPost *.rkt,*.rktl
 \ nnoremap <buffer> <F5> :wa<Bar>terminal racket %<CR>
au BufReadPost *.sh
 \ nnoremap <buffer> <F5> :wa<Bar>terminal bash %<CR>

set autoread
au BufWritePost *.c,*.h silent call FormatC()
function FormatC()
    !indent -kr --no-tabs %
    !touch -d @$(($(stat -c \%X %) + 3)) %
    " reloading via edit makes the buffer jump
    " but checktime has a threshold time that causes it
    " not to reload so I am artifially bumping the timestamp
    " Not this only happens when a file is already to be written.
    " so it shouldn't affect things like make that rely on mtime.
    checktime
endfunction

function KleenKindlePaste()
    "This was make specifically for copying from k&r C Programming Language
    "on cloud kindle reader using Kindle Optimizer Pro Chromium extension

    "back-convert existing chars
    silent! %s/ / /g " backup spaces as nbsp
    silent! %s/\r/ /g " backup newlines as regular space
    silent! %s/\n/ /g " backup newlines as regular space

    " paste text on new line (since now there is only one line)
    normal ojkp

    "convert chars
    silent! %s/ /\r/g "newline come in as spaces
    silent! %s/ / /g "spaces come in as non-breaking spaces
    silent! %s/−/-/g "This is fucked
    silent! %s/′/'/g "Comeon why
    silent! %s/¦/|/g "This makes the text so much clearer, Thanks
endfunction


imap <F5> <ESC><F5>

" git
" found this in the git portable config:
  "Set UTF-8 as the default encoding for commit messages
  au BufReadPre COMMIT_EDITMSG,git-rebase-todo
   \ setlocal fileencodings=utf-8
  "Remember the positions in files with some git-specific exceptions"
  au BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$")
   \           && expand("%") !~ "COMMIT_EDITMSG"
   \           && expand("%") !~ "ADD_EDIT.patch"
   \           && expand("%") !~ "addp-hunk-edit.diff"
   \           && expand("%") !~ "git-rebase-todo" |
   \   exe "normal g`\"" |
   \ endif

  au BufNewFile,BufRead *.patch set filetype=diff
  au BufNewFile,BufRead *.diff set filetype=diff

  au Syntax diff
   \ highlight WhiteSpaceEOL ctermbg=red |
   \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

  au Syntax gitcommit
   \ setlocal spell textwidth=72

  au FileType gitconfig
   \ set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" Functions
"-----------

" print all 16 term colors on each of the 4 solarized backgrounds
" only shows in terminal mode
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

" Toggle between UPPER lower and Title case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" quickly fold/unfold all level 1 folds
function! ToggleFolds()
  " if foldlevel('.') " True if line is at all foldable
  if foldclosed('.') < 0 "True if not closed
      " fold is open or not a fold
      %foldc
  else
      " in a closed fold
      normal! zR
  endif
endfunction
nnoremap <silent>  z<Space> :call ToggleFolds()<CR>


"##############
" Plugin Setup
"##############

" vimtex
" mupdf as viewer
let g:vimtex_view_method = 'mupdf'

" ntpeters/vim-better-whitespace
let g:better_whitespace_ctermcolor = 'green'
let g:better_whitespace_guicolor = 'green'
let g:better_whitespace_enabled = 1

" tpope/vim-commentary
au FileType awk
 \ setlocal commentstring=#\ %s

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Makefile']

