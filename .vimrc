"set clipboard=unnamed
set clipboard=unnamedplus
"set clipboard^=unnamed,unnamedplus

set path=$PWD/**

" Fix backspace in Vim
set bs=2

" Disable beep on wrong command
set vb t_vb=

set term=xterm-256color
set t_Co=256

colorscheme monokai

"colorscheme molokai
"let g:rehash256 = 1

" Disable compatible mode
set nocp

" Status bar information
set ruler

" Show line number
set number

filetype on
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

inoremap jj <Esc>

set runtimepath^=~/.vim/bundle/nerdtree.vim
set runtimepath^=~/.vim/bundle/tagbar.vim

":set foldmethod=syntax

" Case insensitove search
set ignorecase

highlight Search cterm=NONE ctermfg=grey ctermbg=52

" Tabulation
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd FileType c set tabstop=8
autocmd FileType c set shiftwidth=4
autocmd FileType c set softtabstop=4
set expandtab

" Space and tab display
set list
set listchars=tab:>-
" Show tab as an error
match Error /\t/

" Trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Indent guide
:let g:indent_guides_auto_colors = 0
:hi IndentGuidesOdd ctermbg = grey
:hi IndentGuidesEven ctermbg = darkgrey
:let g:indent_guides_start_level = 1
:let g:indent_guides_guide_size = 1

" Gutter bar color
:hi SignColumn ctermbg = black

"" Syntastic
":let g:syntastic_always_populate_loc_list = 1
":let g:syntastic_aggregate_errors = 1
"":highlight link SyntasticError SpellBad
"":highlight link SyntasticWarning SpellCap
":let g:syntastic_python_python_exe = 'python'
":let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pep8']
"":let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pylint']
":let g:syntastic_python_pep8_args='--max-line-length=100'
"" Disable syntastic for Java
":let g:syntastic_java_checkers = ['']

"" Git gutter
"":let g:gitgutter_sign_column_always = 1
"":let g:gitgutter_highlight_lines = 1
":let g:gitgutter_escape_grep = 1

"" Syntastic error color
":hi SpellBad ctermfg=30 ctermbg=235
":hi SpellCap ctermfg=0 ctermbg=183

" Enable CursorLine
set cursorline

highlight ColorColumn ctermbg=235 guibg=#2c2d27
":let &colorcolumn="80,".join(range(120,999),",")
set colorcolumn=81,101

"autocmd FileType c setlocal cc=81
"autocmd FileType cpp setlocal cc=81
"autocmd FileType python setlocal cc=81

" Enable the mouse in all modes
" Do no not select line numbers while selecting with the mouse
"set ttymouse=xterm2
"set mouse=a
set mouse=r

" Highligh all search matches
set hlsearch

autocmd BufNewFile,BufRead *.it set syntax=lua

" Auto load cscope
"cscope add cscope.out
cscope add cscope.out

" Open cscope results in quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-

" ctags -R .. --sort=yes --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q
set tags=tags

" Configure grep to use ripgrep
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" Keep 10 lines at the top and bottom
set scrolloff=10

let mapleader=","

" <F1>

" Find the symbol under the cursor
nmap <F2> :execute "tag " . expand("<cword>")<CR>
" Show tag in preview mode
nmap <F3> :execute "ptag " . expand("<cword>")<CR> " split horizontaly

" Switch between source and header files (in the same folder)
nmap <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

nmap <F5> :buffers<CR>:buffer<Space>

" Press F6 to jump to the previous method in a C++ file
:nmap <F6> ?\v^(\w+\s+)?\w+::\w+\(.*\)<CR>zt

nmap <F7> <C-]>

" Toggle side bar, wich contains the list of tags
nmap <F8> :TagbarToggle<CR>
nmap <S-F8> :TagbarToggle<CR>:TagbarToggle<CR>

" Toggle the file system tree
nmap <F9> :NERDTreeToggle<CR>
nmap <F10> :NERDTreeFind<CR>

" <F11>

" Close the buffer but do not affect the splits
nmap <F12> :cclose<CR>:bp\|bd #<CR>

" Show the quickfix list
nmap <C-Up> :botright copen<CR>
" Hide the quickfix list
nmap <C-Down> :cclose<CR>

" Switch to the previous quickfix list results
:nmap <D-Left> :colder<CR>
" Switch to the next quickfix list results
:nmap <D-Right> :cnewer<CR>

:nmap <C-l> :botright lopen<CR>

:nmap <C-a> :Gstatus<CR>
:nmap <C-t> :Gitv<CR>

" Highlight the word under the cursor
nmap <C-h> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

nmap <S-Tab> :bNext<CR>

" Grep a user input pattern in a specific folder, from the current folder
nmap <C-g> :grep<Space><cword><Space><C-R>=expand('%:p:h')<CR>

" Grep the pattern under the cursor in a specific folder
nmap <C-f> :grep<Space><cword><Space>

" Grep the pattern under the cursor
nmap <C-f>f :grep<Space><cword><CR>

" Find the text under the cursor
nmap <C-f>t yiw:cclose<CR>:cs find t <C-R>=expand("<cword>")<CR><CR>:bd<CR>:cwindow<CR>/<C-R>0<CR>

" Find the symbol under the cursor, find usage
nmap <C-u> yiw:cclose<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>:bd<CR>:cwindow<CR>/<C-R>0<CR>

" List the files in the current folder in a pane
nmap <C-k>f :e<Space><C-d>

" Switch to an other buffer using a part of a filename
"nmap <C-k>o :BufSel<Space>
nmap <C-k> :BufSel<Space>

" Find a file from part of a filename
nmap <C-k>a :cs find f<Space><C-R>=expand('%:p:h')<CR>

" <C-w>x : swap code buffers position

" Show current function
nmap f :call ShowFuncName() <CR>

" Show time and date
nmap t :echo strftime("%b %d %X %z") <CR>

" Git diff (alternative use vnew)
"nmap <C-d> :r ! git diff % > %.diff<CR>:new %.diff<CR>
":nmap <C-d> :VCSDiff<CR>

" Shift+left arrow will go one window left, etc.
nmap <S-Up> :wincmd k<CR>
nmap <S-Down> :wincmd j<CR>
nmap <S-Left> :wincmd h<CR>
nmap <S-Right> :wincmd l<CR>

" Change Color when entering Insert Mode
":autocmd InsertEnter * highlight  CursorLine ctermbg=Grey ctermfg=Red

" Revert Color to default when leaving Insert Mode
":autocmd InsertLeave * highlight  CursorLine ctermbg=DarkCyan ctermfg=None

" Vimdiff colors
":highlight DiffAdd    ctermbg=Black      gui=NONE  guifg=bg  guibg=Green
"" :highlight DiffAdd    ctermbg=22 gui=NONE  guifg=bg  guibg=Green
":highlight DiffDelete ctermbg=52         gui=NONE  guifg=bg  guibg=Red
":highlight DiffChange ctermbg=53         gui=NONE  guifg=bg  guibg=Yellow
"":highlight DiffText   ctermbg=57         gui=NONE  guifg=bg  guibg=Magenta
":highlight DiffText   ctermbg=DarkRed    gui=NONE  guifg=bg  guibg=Magenta


"" Fold
"highlight Folded      ctermfg=Blue    ctermbg=Black       guibg=Blue   guifg=DarkGrey
"highlight FoldColumn  ctermfg=White   ctermbg=DarkGrey    guibg=White  guifg=DarkGrey

"" Always display the status line
":set laststatus=2
":let g:airline#extensions#tabline#enabled=1
":let g:airline#extensions#tabline#buffer_nr_show=1
":let g:airline#extensions#tabline#buffer_nr_format='%s: '
":let g:airline_left_sep =''
":let g:airline_right_sep =''
":let g:airline_detect_modified = 1
":let g:airline_theme='bubblegum'
"":let g:airline_theme='base16-spacemacs'

" Default: :set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
set statusline=
":set statusline+=%1*\ %{@/}\                               "Currently searched
set statusline+=%4*\[%n]                                  "buffernr
":set statusline+=%{GetCurrentMode()}\                      "File+path
set statusline+=%0*\ %<%F\                                "File+path
":set statusline+=%5*\ %y\                                  "FileType
":set statusline+=%5*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
":set statusline+=%5*\ %{&ff}\                              "FileFormat (dos/unix..)
"":set statusline+=%5*\ %{&spelllang}\                       "Spellanguage
set statusline+=%1*\ %{@/}\                               "Currently searched
set statusline+=%0*\ %=\ row:%l/%L\                       "Rownumber/total
set statusline+=%0*\ col:%03c\                            "Column number
:set statusline+=%4*\ \ %2*\%m%4*\%r%w\ %P\ \              "Modified? Readonly? Top/bot

" Color for entering and living insert mode
"au InsertEnter * hi StatusLine ctermfg=DarkGreen ctermbg=Black
"au InsertLeave * hi StatusLine ctermfg=186 ctermbg=Black
au InsertEnter * hi StatusLine ctermfg=DarkGreen ctermbg=237
au InsertLeave * hi StatusLine ctermfg=186 ctermbg=236


"" Python completion
":autocmd FileType  let g:jedi#auto_initialization = 1
":autocmd FileType python let g:jedi#auto_vim_configuration = 1
":autocmd FileType python let g:jedi#use_tabs_not_buffers = 0
":autocmd FileType python let g:jedi#use_splits_not_buffers = "bottom"
":autocmd FileType python let g:jedi#popup_on_dot = 1
":autocmd FileType python let g:jedi#popup_select_first = 0
"" 0, 1 or 2 (cmd)
":autocmd FileType python let g:jedi#show_call_signatures = "0"
":autocmd FileType python let g:jedi#goto_assignments_command = "<leader>g"
":autocmd FileType python let g:jedi#goto_definitions_command = "<leader>d"
":autocmd FileType python let g:jedi#documentation_command = "K"
":autocmd FileType python let g:jedi#usages_command = "<C-u>"
":autocmd FileType python let g:jedi#completions_command = "<C-Space>"
":autocmd FileType python let g:jedi#rename_command = "<leader>r"

" Completion
inoremap <Tab> <C-R>=CleverTab()<CR>

"set complete=.,w,b,u,t,i,d
set complete=w,b,u,t
set completeopt=menu
set wildmode=full
set wildmenu
set expandtab

" Omni completion (not used when ycm is enabled)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cpp set omnifunc=omnifunc=syntaxcomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

"" Note: above omni completion is not used when ycm is enabled
":let g:ycm_min_num_of_chars_for_completion = 2
":let g:ycm_error_symbol = '>>'
":let g:ycm_warning_symbol = '>~'
":let g:ycm_always_populate_location_list = 0


" Compilation
set makeprg=bash\ make.sh
":set errorformat+=%f:%l:\ %m
set errorformat+=%A%f:%l:\ %m,%C%m
"command -nargs=* Make make <args> | botright copen 5
"command -nargs=* Make make <args> | cwindow 5
command -nargs=* Make make <args>
nmap <Leader>b :Make<CR>
"nmap <leader>b :w<CR>:make!<CR><Bar>:cs reset<CR><CR>:botright copen<CR>
":noremap <C-b> :w<CR>:make!<CR><Bar>:botright copen<CR>
":cc      see the current error
":cn      next error
":cp      previous error
":clist   list all errors
"botright copen

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_show_tag_linenumbers = 2
let g:tagbar_autopreview = 0
let g:tagbar_wrap = 0
let g:tagbar_width = 40
"autocmd FileType c,cpp nested :TagbarOpen

"gd : will take you to the local declaration   <=
"gD : will take you to the global declaration  <=
"gg : goes to the first line in the buffer (or provide a count before the command for a specific line)  <=
"G  : goes to the last line (or provide a count before the command for a specific line)  <=
"gf : will go to the file under the cursor    <=
"[[ : will jump to the beginning of the function   <=
"[{ : will jump to the beginning of the block      <=
"
"g* : search for the word under the cursor (like *, but g* on 'rain' will find words like 'rainbow')
"g# : same as g* but in backward direction
"
"g] : will jump to a tag definition (a tag can be a function or variable name, or more)
