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
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Markdown Plugin
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'

" Plugin for code formatting
Plug 'Chiel92/vim-autoformat'

" Plugin for surrounding quick change
Plug 'tpope/vim-surround'

" Plugin for tex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method=''
let g:vimtex_quickfix_mode=0

Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax'

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

" Show command
set showcmd

" Indent using spaces
set expandtab ts=4 sw=4

" Markdown config
set conceallevel=1
let g:tex_conceal = 'abdgm'
let g:vim_markdown_math = 1

" Snippet config
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit='vertical'

" Indentation Settings
" :set tabstop=4 shiftwidth=4 expandtab

" Select in dollar sign
xnoremap i$ :<C-u>normal! T$vt$<CR>
xnoremap a$ :<C-u>normal! T$hvt$l<CR>
onoremap i$ :normal vi$<CR>
onoremap a$ :normal va$<CR>


" Show line number
set number
