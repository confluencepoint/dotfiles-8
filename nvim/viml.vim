packadd cfilter

set undofile
colorscheme neobones

command! -nargs=1 -complete=command      -bar -range Zredir call     zek#redir(<q-args>, <range>, <line1>, <line2>)
command! -nargs=+ -complete=file_in_path -bar        Zgrep  cgetexpr zek#grep(<f-args>)

augroup general_au
	autocmd!
	autocmd VimResized      *                     :wincmd =
	" autocmd ColorScheme     *                     call zek#post_colorscheme()
	autocmd CmdlineLeave    :                     call zek#autoreply()
	autocmd QuickFixCmdPost cgetexpr,cexpr        cwindow
	autocmd TermOpen * setlocal nonumber norelativenumber
	autocmd FileType scala,sbt lua require("metals").initialize_or_attach({})

augroup END

let g:netrw_liststyle = 3
let g:fzf_preview_window = ''
let g:zek_has_replied = v:false
