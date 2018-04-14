runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Plugins from windows
" These were on recently
" Plugin 'gmarik/Vundle.vim', {'pinned': 1}
" Plugin 'chrisbra/Recover.vim', {'pinned': 1}
" Plugin 'tpope/vim-commentary', {'pinned': 1}
" Plugin 'tpope/vim-dispatch', {'pinned': 1}
" Plugin 'ntpeters/vim-better-whitespace', {'pinned': 1}
" Plugin 'tmhedberg/SimpylFold', {'pinned': 1}
" Plugin 'hynek/vim-python-pep8-indent', {'pinned': 1}
"tmhedberg/SimpylFold
"tpope/vim-fugitive
"mbbill/undotree
"chrisbra/Recover.vim
"hynek/vim-python-pep8-indent
"tpope/vim-commentary
"
" Plugins from linux
" Plugin 'tpope/vim-fugitive', {'pinned': 1}
" Plugin 'kien/ctrlp.vim', {'pinned': 1}
" Plugin 'gabrielelana/vim-markdown', {'pinned': 1}
" Plugin 'Matt-Deacalion/vim-systemd-syntax', {'pinned': 1}
" Plugin 'mbbill/undotree', {'pinned': 1}
" Plugin 'lervag/vimtex', {'pinned': 1}
" Plugin 'supertab', {'pinned': 1}
" Plugin 'davidhalter/jedi-vim', {'pinned': 1}
"supertab
"davidhalter/jedi-vim
"tpope/vim-dispatch
"
"
"
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
if has("breakindent")
    set breakindent
    set breakindentopt=min:20,shift:2
endif
" break only on certain characters (such as spaces)
set linebreak

" Use the symbols for tab and EOL
"set listchars=tab:»·,eol:¬ " from windows. shows invisible on diff on linux...hmm
"set listchars=tab:»·,eol:¬
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set list

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set list

" fixes issue where colors are rendered incorrectly because of bold/italics
let g:solarized_italic=0
let g:solarized_bold=0
" make whitespace and special keys like tab invisible except when on top of them
let g:solarized_visibility="low"

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

" show line numbers
set number

set splitbelow
set splitright

" set foldmethod=marker

" jk mapping for normal mode
inoremap jk <esc>
" inoremap <esc> <nop> "disabled because it caused issues with any key that included esc sequences

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

" link X primary with the default register
set clipboard=unnamed

" auto wrap git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically run a file
nnoremap <F5> :w<Enter>:!%:p<Enter>
inoremap <F5> <ESC>:w<Enter>:!%:p<Enter>

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
set secure " disable unsafe commands in local .vimrc files

"sensible settings for put
"nnoremap p P
"nnoremap P p
" my personal dictionary
set spell
set spellfile=~/config/nvim/spell/y2k.utf-8.add

" Allow saving of files as sudo when I forgot to start vim using sudo.
command W w !sudo tee > /dev/null %

" allow deleting and changing without killing my default buffer
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
nmap <silent> <leader>c "_c
vmap <silent> <leader>c "_c

" we all know this trick, unsure of whether it will stick
" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;
" and now a fix for the command-line buffer
" nnoremap q; q:
" vnoremap q; q:
" quickly open the command-line buffer from command mode
" this is much more useful than the q: above
cnoremap jk <C-F>

" make mapping for Y act the same way as D and C
nmap Y y$

" persist undos across vim instances
" set undofile
" set undodir=~/.vim/undodir,~/vimfiles/undodir,.
" set undolevels=5000
" set undoreload=50000

" configure the graphical undo tree
" nnoremap <leader>u :UndotreeToggle<cr>
" let g:undotree_SetFocusWhenToggle = 1

" when removing all inserted chars from the current line,
" break the undo sequence and start a new change
inoremap <C-U> <C-G>u<C-U>

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" enable the bashlike commandline completion
set wildmenu
set wildmode=longest,list

"disabled jan2017
" SuperTab?
" let g:SuperTabDefaultCompletionType = "context"
" autocmd FileType *
"   \ if &omnifunc != '' |
"   \   call SuperTabChain(&omnifunc, "<c-p>") |
"   \ endif

" disable in 2016
" better completion in insert mode
" set completeopt=longest,menuone
" all continuing to type to narrow and then Enter to select
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :'<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"easier omnicompletion
"set omnifunc=syntaxcomplete#Complete
"for some reason C-@ is space in terminals this works in both
" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-Space>

" when editing tex us mupdf as the viewer
let g:vimtex_view_method = 'mupdf'

" y2ks autocommands
au FileType tex setl sw=2 sts=2 et
au FileType awk set commentstring=#\ %s
autocmd Filetype c,cpp  nnoremap <buffer> <F5> :update<Bar>execute '!make '.shellescape(expand('%:r'), 1)<CR><CR>
autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute ':Spawn python '.shellescape(@%, 1)<CR><CR>
autocmd Filetype java   nnoremap <buffer> <F5> :update<Bar>execute '!javac '.shellescape(@%, 1)<CR><CR>

" nav on display lines rather than physical lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
"noremap  <buffer> <silent> 0 g0
"noremap  <buffer> <silent> $ g$

" keep cursor away from the edge
set scrolloff=15

" when diffing a large amount, this makes it quicker
nmap <Right> dp]c
nmap <Up> [c
nmap <Down> ]c

" always make the current directory your working directory
set autochdir

"set the wrapping text width
"set textwidth=64

" found this in the git portable config:
"Set UTF-8 as the default encoding for commit messages
autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8
"Remember the positions in files with some git-specific exceptions"
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$")
  \           && expand("%") !~ "COMMIT_EDITMSG"
  \           && expand("%") !~ "ADD_EDIT.patch"
  \           && expand("%") !~ "addp-hunk-edit.diff"
  \           && expand("%") !~ "git-rebase-todo" |
  \   exe "normal g`\"" |
  \ endif

  autocmd BufNewFile,BufRead *.patch set filetype=diff
  autocmd BufNewFile,BufRead *.diff set filetype=diff

  autocmd Syntax diff
  \ highlight WhiteSpaceEOL ctermbg=red |
  \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

  autocmd Syntax gitcommit setlocal textwidth=74

" allow more backspacing
set backspace=indent,eol,start

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

" do not store global and local values in a session
set ssop-=options

" from visual mode start a search and replace
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

set ignorecase
set smartcase

" plugin setup
" ntpeters/vim-better-whitespace
highlight ExtraWhitespace ctermbg=6 guibg=#2aa198

" tmhedberg/SimpylFold
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

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

" don't search included files in autocomplete
setglobal complete-=i
