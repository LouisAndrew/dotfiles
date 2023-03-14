" Have j and k navigate visual lines rather than logical ones
map j gj
map k gk

" I like using H and L for beginning/end of line
map H ^
map L $

map K {
map J }

map ' *
map ; #
map <C-d> <C-d>zz
map <C-u> <C-u>zz

" Quickly remove search highlights
nmap <F9> :nohl

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
exmap forward obcommand app:go-forward