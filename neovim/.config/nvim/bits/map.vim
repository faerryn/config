noremap <silent> <Leader> <Nop>
noremap <silent> s <Nop>

nnoremap Y y$

nnoremap <silent> ]a <cmd>next<CR>
nnoremap <silent> [a <cmd>previous<CR>
nnoremap <silent> ]A <cmd>last<CR>
nnoremap <silent> [A <cmd>first<CR>

nnoremap <silent> ]b <cmd>bnext<CR>
nnoremap <silent> [b <cmd>bprevious<CR>
nnoremap <silent> ]B <cmd>blast<CR>
nnoremap <silent> [B <cmd>bfirst<CR>

nnoremap <silent> <Leader>l <cmd>lopen<CR>
nnoremap <silent> <Leader>q <cmd>copen<CR>
autocmd FileType qf nnoremap <silent> <buffer> <Esc> <C-W>c

nnoremap <silent> ]q <cmd>cnext<CR>
nnoremap <silent> [q <cmd>cprevious<CR>
nnoremap <silent> ]Q <cmd>clast<CR>
nnoremap <silent> [Q <cmd>cfirst<CR>

nnoremap <silent> ]l <cmd>lnext<CR>
nnoremap <silent> [l <cmd>lprevious<CR>
nnoremap <silent> ]L <cmd>llast<CR>
nnoremap <silent> [L <cmd>lfirst<CR>

onoremap <silent> ih i(
onoremap <silent> ah a(
onoremap <silent> ij i{
onoremap <silent> aj a{
onoremap <silent> ik i[
onoremap <silent> al a[
onoremap <silent> il i<
onoremap <silent> ak a<

vnoremap <silent> ih i(
vnoremap <silent> ah a(
vnoremap <silent> ij i{
vnoremap <silent> aj a{
vnoremap <silent> ik i[
vnoremap <silent> al a[
vnoremap <silent> il i<
vnoremap <silent> ak a<
