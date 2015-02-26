syntax enable

set t_Co=16
set background=dark
colorscheme solarized

set mouse=n

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set list
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:>»,eol:¬
"fixes issue where colors are rendered incorrectly because of bold/italics
let g:solarized_italic=0
let g:solarized_bold=0
"make whitespace and special keys like tab invisible except when on top of them
let g:solarized_visibility="low"


"print all 16 term colors on each of the 4 solarized backgrounds
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

"show line numbers
set number

set splitbelow
set splitright

set foldmethod=marker

"force jk mapping for normal mode
inoremap jk <esc>
" inoremap <esc> <nop> "disabled because it caused issues with any key that included esc sequences

"dont let arrow keys be used at all
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>

" link X primary with the default register
set clipboard=unnamed

"auto wrap git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

"automatically run a file
nnoremap <F5> :w<Enter>:!%:p<Enter>

"set up tabstops and converting tabs to spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab


"enable partial matching as I type
set incsearch

"enable highlighting on searches
set hlsearch

"increase the memorizes commands in vim, also increases ctrlp historyi
set history=1000

nnoremap <SPACE> <Nop>
let mapleader=" "

"stuff for ctrlP (fuzzy searching)
let g:ctrlp_show_hidden = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|Android|vids|musik|pics|oldhome|AndroidStudio|\.gradle|\.cache|eclipse4\.3\.1)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
"cache across sessions
let g:ctrlp_clear_cache_on_exit = 0
"make it taller
let g:ctrlp_max_height = 20
"recent files to remember
let g:ctrlp_mruf_max = 2500
"
let g:ctrlp_mruf_exclude = '/tmp/.*' 
"disable MRU mode searching
let g:ctrlp_mruf_default_order = 1
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>
nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>o :CtrlPMixed<CR>

" enable per-directory .vimrc files
set exrc           
set secure " disable unsafe commands in local .vimrc files

"sensible settings for put
nnoremap p P
nnoremap P p
