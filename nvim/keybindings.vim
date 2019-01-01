nnoremap <Space> <nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

nnoremap j gj
nnoremap k gk

" files
nnoremap <silent><leader>ff :<c-u>Denite file_rec buffer -winheight=`30*winheight(0)/100`<cr>
nnoremap <silent><leader>fj :<c-u>Denite junkfile -winheight=`30*winheight(0)/100`<cr>
nnoremap <leader>ft <ESC>:TagbarToggle<cr>
nnoremap <leader>fs <ESC>:w<cr>
" to remove white space from a file.
nnoremap <leader>fW :%s/\s\+$//<cr>:let @/=''<CR>

" buffers
nnoremap <leader>bd :bd<cr>
nnoremap <leader><tab> :b#<CR>

" search
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <leader>s/ :<c-u>Denite -auto-preview -vertical-preview grep<cr>
nnoremap <leader>s* :<c-u>DeniteCursorWord -auto-preview -vertical-preview grep<cr>
nnoremap <leader>/ :<C-u>grep!<Space>
nnoremap <leader>* :grep! "\b<C-R><C-W>\b"<CR>
nnoremap <BS> :nohlsearch<cr>
nnoremap <silent><leader>ss :<c-u>Denite outline line -winheight=`30*winheight(0)/100`<cr>
nmap <silent>[s <Plug>DashSearch
nmap <silent>[<C-s> <Plug>DashGlobalSearch

" for browsing the input history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

nmap - <Plug>VinegarVerticalSplitUp

" Select just pasted text.
nnoremap <leader>V V`]

nnoremap <silent><leader>qq :SmartClose<cr>

let g:mc = 'y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>'
nnoremap cn *``cgn
nnoremap cN *``cgN
vnoremap <expr> cn g:mc . "``cgn"
vnoremap <expr> cN g:mc . "``cgN"

function! SetupCR()
  nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
endfunction
nnoremap cq :call SetupCR()<CR>*``qz
nnoremap cQ :call SetupCR()<CR>#``qz
vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:jump_to_next_source>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:jump_to_previous_source>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplitswitch>', 'noremap')

nnoremap <leader>o <c-w><Bar><c-w>_<cr>
nnoremap <leader>= <c-w>=

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <silent>K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <silent>[<C-d> :call LanguageClient#textDocument_definition()<cr>
    nnoremap <silent>[d :call LanguageClient#textDocument_hover()<cr>
    nnoremap <silent>[<C-n> :call LanguageClient#textDocument_rename()<cr>
    nnoremap <silent>[<C-r> :call LanguageClient#textDocument_references()<cr>
    set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  endif
endfunction
augroup keybindings_au
  autocmd!

  autocmd FileType * call LC_maps()
augroup END

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

function! CCR()
  let cmdline = getcmdline()
  if cmdline =~ '\v\C^(ls|files|buffers)'
    return "\<CR>:b"
  elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
    return "\<CR>:"
  elseif cmdline =~ '\v\C^(dli|il)'
    return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    set nomore
    return "\<CR>:sil se more|e #<"
  elseif cmdline =~ '\C^changes'
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    return "\<CR>:u "
  elseif cmdline =~ '\C^reg'
    return "\<CR>:norm! \"p\<Left>"
  else
    return "\<CR>"
  endif
endfunction
cnoremap <expr> <CR> CCR()
