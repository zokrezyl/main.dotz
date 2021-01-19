" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align' "A simple, easy-to-use Vim alignment plugin

Plug 'mattboehm/vim-unstack' " for unstacking python error stack

Plug 'tpope/vim-fugitive'  "vim git wrapper
Plug 'junegunn/vim-github-dashboard'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" don't use gocode: https://octetz.com/posts/vim-as-go-ide
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'LnL7/vim-nix'

Plug 'mikelue/vim-maven-plugin'

" Markdown rendering
" none is good.. using grip from command line. that allows me alse to use my
" own tool richmify to convert raw.md to md
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
"TODO ... follow the other equivalent pluginns
"Plug 'rhysd/nyaovim-markdown-preview'
"Plug 'rhysd/nyaovim-popup-tooltip'
"Plug 'rhysd/nyaovim-mini-browser'

Plug 'itspriddle/vim-shellcheck'

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" traditional ones disabled for the moment as testing language server
"Plug 'davidhalter/jedi-vim' "python autocompletion library
"Plug 'vim-scripts/Pydiction' "for python, may conflict with jedi-vim
"Plug 'python-mode/python-mode' "for python, may conflict with jedi-vim
"
" Plug 'jeetsukumaran/vim-pythonsense'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" the autozimu/LanguageClient-neovim does not work ATM with java
" therefore using vim-lsp (see below the settings)
" Plug 'autozimu/LanguageClient-neovim'  
"
" https://github.com/w0rp/ale/issues/1577
" https://www.reddit.com/r/neovim/comments/8xn0aj/cocnvim_intellisense_engine_for_neovim_featured/e2clg6i/
" https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Plug 'neoclide/coc-python' "they are managed by coc itself
" Plug 'neoclide/coc-java' "see above

Plug 'martong/vim-compiledb-path' " for compile_commands.json to vim path

Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'


Plug 'thanethomson/vim-jenkinsfile'

Plug 'vim-scripts/taglist.vim'
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

Plug 'KabbAmine/zeavim.vim' "for documentation

Plug 'joker1007/unite-pull-request'

Plug 'mogelbrod/vim-jsonpath'
Plug 'vim-scripts/MultipleSearch'
Plug 'mattn/webapi-vim'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'bps/vim-tshark'

Plug 'airblade/vim-gitgutter'

"Plug 'szymonmaszke/vimpyter'

Plug 'matze/vim-lilypond'


Plug 'Shougo/unite.vim'

Plug 'rafi/vim-unite-issue', {
    \ 'directory': 'unite-issue',
    \  'unite_sources': [ 'issue' ],
    \  'depends': [
    \    'mattn/webapi-vim', 'tyru/open-browser.vim', 'Shougo/unite.vim'
    \  ]
    \ }


" Plug 'autozimu/LanguageClient-neovim', {
 "   \ 'branch': 'next',
 "   \ 'do': 'bash install.sh',
 "   \ }

"Plug 'majutsushi/tagbar'
" Plug 'w0rp/ale' "https://github.com/w0rp/ale
"24 color plugins
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'whatyouhide/vim-gotham'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'

"Plug 'google/vim-maktaba'
"Plug 'google/vim-codereview'
"Plug 'google/vim-glaive'
"
Plug 'bps/vim-tshark'
"
"
Plug 'yuratomo/w3m.vim'

Plug 'supercollider/scvim' " fun


Plug 'alok/notational-fzf-vim' " for note takeing 

Plug 'pseewald/anyfold'



call plug#end()



" SETTINGS FOR Plug 'prabirshrestha/vim-lsp'
" FROM https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Java
" 2019.05.23 ... the alternative 
if executable('java') && filereadable(expand('/opt/jdt/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('/opt/jdt/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar'),
        \     '-configuration',
        \     expand('/opt/jdt/config_linux'),
        \     '-data',
        \     getcwd()
        \ ]},
        \ 'whitelist': ['java'],
        \ })
endif
" END SETTINGS FOR Plug 'prabirshrestha/vim-lsp'




" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:deoplete#enable_at_startup = 1


let g:fzf_command_prefix = 'Fzf'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~90%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

source $HOME/.config/nvim/keymaps.vim


set background=dark
set termguicolors
"colorscheme gotham256
colorscheme solarized8_high
"colorscheme solarized8
" Initialize plugin system
"
"
"

set dictionary=/usr/share/dict/british-english
autocmd FileType groovy          nnoremap <buffer> ,cc :!curl -n http://ci-dev.da-int.net/scriptText --data-urlencode "script=$(cat %)"<CR>
autocmd FileType python          nnoremap <buffer> ,cc :!python3 %<CR>

let g:pymode_python = 'python3'
let g:pymode_folding = 1
let g:pymode_rope = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode = 1
let g:pymode_run = 0
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_on_fly = 1
let g:pymode_indent = 1
let g:pymode_doc_bind = 'K'
let g:pymode_lint_checkers = ['pylint']


let g:ale_python_pylint_executable = 'pylint3'
let g:ale_python_yapf_executable = 'yapf3'

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint3']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0



"Jedi is the python stuff
let g:jedi#popup_on_dot = 1
let g:jedi#goto_command = "ctrl-]"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "ctrl-["
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
"let g:jedi#force_py_version=3

let g:syntastic_python_python_exe = 'python3'

let g:gitgutter_map_keys = 0
let g:MultipleSearchMaxColors = 20

let g:SaveUndoLevels = &undolevels 
let g:BufSizeThreshold = 1000000 



set statusline=%f[%n]%h%m%r%{fugitive#statusline()}%{Tlist_Get_Tagname_By_Line()}%<%=%08l/%08L\ %03b/0x%02B\ %03c/v%03v\ %02P


set showmatch
" use the cool tab complete menu
set wildmenu
set wildignore=*.o,*~

set shiftround
set autoindent
set autowrite

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab


set laststatus=2

set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch
set hlsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

set hidden " this keeps inactive buffers in memory.. usefull for afile (allfile) and fileliste

" Complete options (disable preview scratch window)
set completeopt="menu,menuone,longest"
" Limit popup menu height
set pumheight=15
set ut=200

set history=10000

filetype plugin on

" let g:w3m#command = '/s/sc.t/home/misi/bin/w3m.wrapper'

let g:nv_search_paths = ['~/my-wiki']

inoremap <TAB> <C-n>

" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"
function! ShowScreen()
  call chansend(v:stderr, "\033[?1049l")
  call getchar()
  call chansend(v:stderr, "\033[?1049h")
  mode
endfunction


"let g:markdown_preview_auto = 1
let g:mkdp_auto_start = 1

let g:go_def_mapping_enabled = 0
