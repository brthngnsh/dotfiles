"options
set background=dark
set clipboard=unnamedplus "enables the clipboard between Vim/Neovim and other applications
set completeopt=noinsert,menuone,noselect "modifies the auto-complete menu to behave more like an IDE.
set cursorline "highlights the current line in the editor.
set hidden "hide unused buffers
set inccommand=split "show replacements in a split screen, before applying to the file
set mouse=a "allows the use of the mouse in the editor
set number "shows line numbers
set splitbelow splitright "changes split screen behavior with the command split->horizontally to right & vslit->vertically to bottom
set title "show the file title
set ttimeoutlen=0 "time in milliseconds to run commands
set wildmenu "shows a more advanced menu for auto-completion suggestions
set encoding=UTF-8 "Enables UTF-8 encoding
"Tabs size
set expandtab "transforms tabs into spaces
set shiftwidth=4 "number of spaces for indentation
set tabstop=4 "number of spaces for tabs
set smarttab "Enabling this will make the tab key (in insert mode) insert spaces or tabs to go to the next indent of the next tabstop

filetype plugin indent on
syntax on

" Some servers have issues with backup files
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300 "fast dialog response
set shortmess+=c "set shortmess+=c
set signcolumn=yes "always show sign columns

"Plugins
call plug#begin()

"vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

"syntax highlighting
Plug 'sheerun/vim-polyglot'

"auto pairing brackets
Plug 'jiangmiao/auto-pairs'

"Sidbar to access fiels
Plug 'preservim/nerdtree'

"Completion and formatter
Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}

"Dracula theme
Plug 'dracula/vim'

" For Git integrations
Plug 'tpope/vim-fugitive'

" Copy-Paste emulation in vim
Plug 'svermeulen/vim-cutlass'

" Better Line Search
Plug 'jremmen/vim-ripgrep'

" Show indentation Lines
Plug 'Yggdroot/indentLine'

" Multiline support
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"
" "Python autocomplete
Plug 'davidhalter/jedi-vim'
call plug#end()

"config
"Airline
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"NERDtree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <C-t> :NERDTreeToggle<CR>

"Tabs
nnoremap <C-k> gT
nnoremap <C-l> gt
"nnoremap <silent> <S-t> :tabnew<CR>

"Function key utilities
nnoremap <F4> :bd<CR>
nnoremap <F6> :sp<CR>:terminal<CR>

" indent line
let g:indentLine_enabled = 1

"dracula
set termguicolors
colorscheme dracula

" COC config
let g:coc_disable_startup_warning = 1

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>