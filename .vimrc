set number
syntax on
colorscheme ron
set cursorline
set hlsearch

" ============================================================================
" Folder View Configuration (Netrw - built-in file explorer)
" ============================================================================
let g:netrw_banner = 0         " Hide the help banner at the top of the browser
let g:netrw_liststyle = 3      " Use tree-style listing
let g:netrw_browse_split = 4   " Open files in the previous window (prevent replacing explorer)
let g:netrw_altv = 1           " Open splits to the right
let g:netrw_winsize = 25       " Set the initial width of the sidebar to 25%

" Shortcut to toggle the folder view (Ctrl + n)
nnoremap <silent> <C-n> :Lexplore<CR>
