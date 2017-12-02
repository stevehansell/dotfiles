" vim: nowrap fdm=marker

" Plugins {{{
packadd minpac
call minpac#init()

call minpac#add('tpope/vim-unimpaired')
call minpac#add('junegunn/fzf.vim')
call minpac#add('mhartington/oceanic-next')
call minpac#add('dracula/vim')
call minpac#add('itchyny/lightline.vim')
call minpac#add('airblade/vim-gitgutter')

call minpac#add('christoomey/vim-tmux-runner')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('tpope/vim-surround')
call minpac#add('w0rp/ale')

call minpac#add('othree/yajs.vim')
call minpac#add('othree/html5.vim')
call minpac#add('briancollins/vim-jst')
call minpac#add('tpope/vim-commentary')

call minpac#add('ternjs/tern_for_vim')
call minpac#add('carlitux/deoplete-ternjs')
call minpac#add('Shougo/neocomplcache')
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('Shougo/neosnippet.vim')
call minpac#add('Shougo/neosnippet-snippets')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
" }}}

" UI {{{
syntax enable
filetype indent plugin on " Loads lang specific indent settings
set autoindent          " Copy indent from current line when starting new line
set smartindent         " Autoindents next line based on current syntax
set copyindent          " Copy the structure of the existing lines indent when autoindenting a new line.
set number
set inccommand=nosplit
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
set termguicolors
colorscheme dracula
let g:lightline = {
  \ 'colorscheme': 'Dracula',
  \ }

set rnu
set diffopt=filler,vertical,context:4
set ruler


let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_list_hide = '\.pyc,__init__\.py,\.egg$,.*\.egg-info/$,\.ropeproject/$,\.DS_Store$,node_modules/$,\.git/$,\.json\.gzip$,\.vscode/$'
" }}}

" Syntax + Autocompletion {{{
let g:deoplete#enable_at_startup = 1
set completeopt+=noselect,noinsert

let g:neosnippet#snippets_directory='~/Development/snip-snips/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" }}}

" Mappings {{{
nnoremap <SPACE> <Nop>
let mapleader=' '

nnoremap <C-n> :Ex<CR>
nnoremap <leader>Ce :vsplit $VIMCONFIG/init.vim<CR>
nnoremap <leader>Cs :source $VIMCONFIG/init.vim<CR>
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <silent> <leader>l :nohl<CR>

vnoremap < <gv
vnoremap > >gv
nnoremap < v$<<esc>
nnoremap > v$><esc>

" }}}

" Window Management {{{
autocmd VimResized * :wincmd = " Automatically rebalance windows on resize
set splitright
set splitbelow
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" }}}

" Terminal Mappings {{{
if has('nvim')
  tnoremap <Esc> <C-\><C-n> tnoremap <C-v><Esc> <Esc>
endif
" }}}

" Tmux Runner Settings {{{
let g:VtrStripLeadingWhitespace=0
let g:VtrClearEmptyLines=0
let g:VtrAppendNewline=1

let g:VtrUseVtrMaps=1

nnoremap <leader>rn :VtrOpenRunner<CR>
nnoremap <leader>rk :VtrKillRunner<CR>
nnoremap <leader>ra :VtrAttachToPane<CR>
nnoremap <leader>rf :VtrFocusRunner<CR>
nnoremap <leader>rs :VtrSendCommandToRunner<CR>

"}}}

" ALE {{{
let g:ale_linters = {
\ 'css': ['prettier'],
\ 'javascript': ['prettier', 'eslint'],
\ 'json': ['prettier'],
\ 'html': ['tidy'],
\ 'scss': ['prettier']
\}

let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_javascript_prettier_use_local_config = 1
" }}}

" Autogroups {{{
augroup configgroup
autocmd!
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab shiftround
autocmd FileType javascript,typescript,java,json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab shiftround conceallevel=0
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab shiftround
autocmd FileType html,ejs,jst setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab shiftround
autocmd FileType css,scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab shiftround
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab shiftround
autocmd BufEnter *.sh,*.zsh setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.md setlocal textwidth=80 smarttab shiftround nospell
au BufNewFile,BufRead *.ejs set filetype=html
augroup END
" }}}
