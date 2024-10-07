call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'hiphish/rainbow-delimiters.nvim'
Plug 'vim-scripts/IndexedSearch'
Plug 'tpope/vim-endwise'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
    set termguicolors
endif

" don't hide characters in json
let g:indentLine_setConceal = 0

" Theme
syntax enable
colorscheme tender

" set airline theme
let g:airline_theme = 'tender'
let g:airline_powerline_fonts = 1

" HACK to workaround the fact that tender doesn't publish comment groups
" currently
hi @comment.todo guifg=#f43753
hi @comment.note guifg=#b3deef
hi @comment.warning guibg=#ffc24b guifg=#202020
hi @comment.error guibg=#f43753 guifg=#202020
hi @keyword.directive guifg=#c9d05c

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
	exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

set mouse=

set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

let g:rainbow_active = 1

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <c-p> :FZF<cr>

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set colorcolumn=100

" figure out indent from file
set smartindent
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set listchars+=space:-

lua require("init")
