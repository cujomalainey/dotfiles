" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
set rtp+=/usr/local/opt/fzf
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Multiple Plug commands can be written in a single line using | separators
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/IndexedSearch'
Plug 'tpope/vim-endwise'
Plug 'godlygeek/tabular'
Plug 'briandoll/change-inside-surroundings.vim'
Plug 'tomtom/tcomment_vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'Shougo/neoinclude.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Initialize plugin system
call plug#end()

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:airline_powerline_fonts = 1

" Theme
syntax enable
colorscheme tender
set number
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:deoplete#enable_at_startup = 1
" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" figure out indent from file
set smartindent

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif
