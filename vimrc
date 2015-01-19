syntax enable

set t_Co=16
set background=dark
colorscheme solarized

set mouse=a

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
set tabstop=8 softtabstop=8 shiftwidth=8 expandtab

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
