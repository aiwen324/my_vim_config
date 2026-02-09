" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Nerdtree config for auto open
" autocmd vimenter * NERDTree

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Following will install fzf, user can decide if he wants to manually install
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Markdown Plugin
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'

" Markdown Preview Plugin
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Plugin for code formatting
" NOTE: I didn't figure out exact way to turn off auto format, I didn't think
" I truned it on
" Plug 'Chiel92/vim-autoformat'

" Plugin for surrounding quick change
Plug 'tpope/vim-surround'

" Plugin vim multi selection
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Plugin YCM
" NOTE: This plugin is heavy, only install it if you really need it
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }
" let g:ycm_always_populate_location_list = 1

" Plugin for linediff (block diff)
Plug 'AndrewRadev/linediff.vim'

" Plugin for heuristic indent
Plug 'tpope/vim-sleuth'

" Plugin for faster scrolling
Plug 'Houl/repmo-vim'

" Plugin for indent line guide
" NOTE: This plugin will cause some visual problem in markdown file if you
" change its default bg color
Plug 'Yggdroot/indentLine'

" Plugin for checkhealth
" if !has('nvim')
"     Plug 'rhysd/vim-healthcheck'
" endif

" Plugin for tex
" Plug 'lervag/vimtex'
" let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura'
" let g:vimtex_quickfix_mode=0

" Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax'

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Fix blue text issue
set background=dark
colorscheme desert
" Make cursor more visible in desert
highlight MatchParen cterm=underline,bold ctermbg=none ctermfg=magenta
" Fix Session.vim not taking MatchParen
augroup DesertFix
  autocmd!
  autocmd ColorScheme desert highlight MatchParen cterm=underline,bold ctermbg=none ctermfg=magenta
augroup END
" Show command
set showcmd

" Indent using spaces
set expandtab ts=2 sw=2 sts=2

" Markdown config
set conceallevel=1
let g:tex_conceal = 'abdgm'
let g:vim_markdown_math = 1

" Set highlight
set hlsearch

" Snippet config
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger='<tab>'
" let g:UltiSnipsJumpForwardTrigger='<tab>'
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsEditSplit='vertical'

" Select in dollar sign
xnoremap i$ :<C-u>normal! T$vt$<CR>
xnoremap a$ :<C-u>normal! T$hvt$l<CR>
onoremap i$ :normal vi$<CR>
onoremap a$ :normal va$<CR>


" Show line number
set number

" Toggle paste mode
set pastetoggle=<F2>

" [Custom]
" Visual select search, <leader> is '\' on the keyboard
" return a representation of the selected text
" suitable for use as a search pattern
function GetVisualSelection()
  let old_reg = @a
  normal! gv"ay
  let raw_search = @a
  let @a = old_reg
  return substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction

xnoremap <leader>r :<C-u>%s/<C-r>=GetVisualSelection()<CR>/
xnoremap <leader>t :/<C-r>=GetVisualSelection()<CR>

" NOTE: I don't know why I had this but I've commented following when I am
" syncing this change.
" Change modifyOtherCase to avoid >4;2m weird chars
" let &t_TI = ""
" let &t_TE = ""
" set keyprotocol=
" let &term=&term

" Set vim linewrap only break at special chars
set linebreak

" Disable autoselect
set clipboard-=autoselect
set guioptions-=a

" Show as much as possible text for wrapped line
set display+=lastline

" Show cursor line and cursor column (For better navigation)
set cursorline
set cursorcolumn

" [Linux Server (Maybe)]
" Fallback for terminals that don't support <C-Left>
noremap <Esc>[1;5D <C-Left>
inoremap <Esc>[1;5D <C-Left>
cnoremap <Esc>[1;5D <C-Left>
noremap <Esc>[1;5C <C-Right>
inoremap <Esc>[1;5C <C-Right>
cnoremap <Esc>[1;5C <C-Right>

" [MacOS]
" Enable filetype detection and syntax detection on Macos.
" I don't know why it was not turned on by default
"–– Enable syntax highlighting ––
syntax on

"–– Enable filetype detection, plugins & indenting ––
filetype plugin indent on


" Change auto complete behavior
set wildmode=list:longest 

" Macos fzf path managed by brew
set rtp+=/opt/homebrew/opt/fzf

" [Custom]
" Scripts for line wrapping and corresponding config 
" NOTE: I found this is generally useful
" Move screen lines when text wrapped
" noremap <silent> <Leader>w :call ToggleWrap()<CR>
" function ToggleWrap()
"   if &wrap
"     echo "Wrap OFF"
"     setlocal nowrap
"     set virtualedit=all
"     silent! nunmap <buffer> <Up>
"     silent! nunmap <buffer> <Down>
"     silent! nunmap <buffer> <Home>
"     silent! nunmap <buffer> <End>
"     silent! iunmap <buffer> <Up>
"     silent! iunmap <buffer> <Down>
"     silent! iunmap <buffer> <Home>
"     silent! iunmap <buffer> <End>
"   else
"     echo "Wrap ON"
"     setlocal wrap linebreak nolist
"     set virtualedit=
"     setlocal display+=lastline
"     noremap  <buffer> <silent> <Up>   gk
"     noremap  <buffer> <silent> <Down> gj
"     noremap  <buffer> <silent> <Home> g<Home>
"     noremap  <buffer> <silent> <End>  g<End>
"     inoremap <buffer> <silent> <Up>   <C-o>gk
"     inoremap <buffer> <silent> <Down> <C-o>gj
"     inoremap <buffer> <silent> <Home> <C-o>g<Home>
"     inoremap <buffer> <silent> <End>  <C-o>g<End>
"   endif
" endfunction
" 
" function CheckWrap()
"   if &wrap
"     set virtualedit=
"     setlocal display+=lastline
"     noremap  <buffer> <silent> <Up>   gk
"     noremap  <buffer> <silent> <Down> gj
"     noremap  <buffer> <silent> <Home> g<Home>
"     noremap  <buffer> <silent> <End>  g<End>
"     inoremap <buffer> <silent> <Up>   <C-o>gk
"     inoremap <buffer> <silent> <Down> <C-o>gj
"     inoremap <buffer> <silent> <Home> <C-o>g<Home>
"     inoremap <buffer> <silent> <End>  <C-o>g<End> 
"   else
"     set virtualedit=all
"     silent! nunmap <buffer> <Up>
"     silent! nunmap <buffer> <Down>
"     silent! nunmap <buffer> <Home>
"     silent! nunmap <buffer> <End>
"     silent! iunmap <buffer> <Up>
"     silent! iunmap <buffer> <Down>
"     silent! iunmap <buffer> <Home>
"     silent! iunmap <buffer> <End> 
"   endif
" endfunction
" " Map keys depends on wrapped state
" :call CheckWrap()

" Modify diff option
" For some vim it doesn't have this option
set diffopt+=internal,algorithm:patience

" [repmo-vim]
" Faster scrolling key mapping
" map a motion and its reverse motion:
:noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
:noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

" if you like `:noremap j gj', you can keep that:
:map <expr> j repmo#Key('gj', 'gk')|sunmap j
:map <expr> k repmo#Key('gk', 'gj')|sunmap k

" repeat the last [count]motion or the last zap-key:
:map <expr> ; repmo#LastKey(';')|sunmap ;
:map <expr> , repmo#LastRevKey(',')|sunmap ,

" add these mappings when repeating with `;' or `,':
:noremap <expr> f repmo#ZapKey('f')|sunmap f
:noremap <expr> F repmo#ZapKey('F')|sunmap F
:noremap <expr> t repmo#ZapKey('t')|sunmap t
:noremap <expr> T repmo#ZapKey('T')|sunmap T


" ============================================================================================
" [markdown-preview]
" Config fore Markdown Previewer
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" normal/insert
" <Plug>MarkdownPreview
" <Plug>MarkdownPreviewStop
" <Plug>MarkdownPreviewToggle

" example
nmap <C-s> <Plug>(MarkdownPreview)
nmap <M-s> <Plug>(MarkdownPreviewStop)
nmap <C-p> <Plug>(MarkdownPreviewToggle)

" fix indent issue in markdown
au filetype markdown set formatoptions+=ro
au filetype markdown set comments=b:*,b:-,b:+,b:1.,n:>
" =========================================================================================================
