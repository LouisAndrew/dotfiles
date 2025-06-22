" Have j and k navigate visual lines rather than logical ones

exmap followlink obcommand editor:follow-link
nmap gd :followlink<CR>

exmap closefile obcommand workspace:close
nmap W :closefile<CR>

map j gj
map k gk

imap jj <Esc>

" I like using H and L for beginning/end of line
map H ^
map L $

map K {
map J }

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" open file with <c-o> and search with <c-f> done via global keymap
exmap savefile obcommand editor:save-file
nmap S :savefile<CR>

" Quickly remove search highlights
nmap <F9> :nohl

" Yank to system clipboard
set clipboard=unnamed
