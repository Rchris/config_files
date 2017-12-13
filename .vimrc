"/usr/share/vim/vim74/

:set clipboard=unnamedplus

:set term=xterm-256color
:set t_Co=256

":colorscheme default
":colorscheme peachpuff
":colorscheme zellner
":colorscheme pablo
":colorscheme delek
":colorscheme darkblue

" Disable compatible mode
:set nocp

:execute pathogen#infect()

:filetype on
:filetype plugin on
:filetype indent on

" Enable syntax highlighting
:syntax on

":set foldmethod=syntax

" Case insensitove search
:set ignorecase

" Tabulation
:set tabstop=4
:set shiftwidth=4
:set expandtab

:set list listchars=tab:→\ ,trail:·

" Indent guide
:let g:indent_guides_auto_colors = 0
:hi IndentGuidesOdd ctermbg = grey
:hi IndentGuidesEven ctermbg = darkgrey
:let g:indent_guides_start_level = 1
:let g:indent_guides_guide_size = 1

" Gutter bar color
:hi SignColumn ctermbg = black

" Syntastic
:let g:syntastic_always_populate_loc_list = 1
:let g:syntastic_aggregate_errors = 1
":highlight link SyntasticError SpellBad
":highlight link SyntasticWarning SpellCap
:let g:syntastic_python_python_exe = 'python'
:let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pep8']
":let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pylint']
:let g:syntastic_python_pep8_args='--max-line-length=100'
" Disable syntastic for Java
:let g:syntastic_java_checkers = ['']

" Git gutter
":let g:gitgutter_sign_column_always = 1
":let g:gitgutter_highlight_lines = 1
:let g:gitgutter_escape_grep = 1

" Syntastic error color
:hi SpellBad ctermfg=30 ctermbg=235
:hi SpellCap ctermfg=0 ctermbg=183

" Enable CursorLine
:set cursorline
:hi CursorLine ctermfg=NONE ctermbg=234 term=NONE cterm=NONE

:highlight ColorColumn ctermbg=235 guibg=#2c2d27
":let &colorcolumn="80,".join(range(120,999),",")
:set colorcolumn=101

:autocmd FileType c setlocal cc=81
:autocmd FileType cpp setlocal cc=81
:autocmd FileType python setlocal cc=101

" Tabulation
:set tabstop=4
:set shiftwidth=4
:set expandtab

" Enable the mouse in all modes
" Do no not select line numbers while selecting with the mouse
:set mouse=a

" Highligh all search matches
:set hlsearch

:let mapleader = ","

:nmap <C-n><C-n> :set invnumber<CR>:IndentGuidesToggle<CR>

" Print the current filename + path
":nmap <C-n> :! echo %<CR>

:nmap <S-Tab> :bNext<CR>

" Grep a user input pattern in a specific folder
:nmap <C-G> :GrepPaternFolder<Space>

" Grep the pattern under the cursor in a specific folder
:nmap <C-F>f :GrepFolder<Space>

" Grep the patern under the cursor in a specific folder
:nmap <C-F> :Ag<Space><cword><CR>

" Find the text under the cursor
"  grep -rin --include '*.cpp' "TEXT" .
"  grep -rin --include=*.{cpp,h} "TEXT" .
:nmap <C-F>c :execute "cs find t " . expand("<cword>") <Bar> botright copen <CR>

" Find the symbol under the cursor, find usage
:nmap <C-U> :execute "cs find s " . expand("<cword>") <Bar> botright copen <CR>

" List the files in the current folder in a pane
:nmap <C-k>f :e<Space><C-d>

" Find a folder or a file, add * at the end if necessary
:let g:unite_ignore_source_files = ['.git*', '.git/', '*.odg', '*.db', '*.pdf', '*.dot']
:nmap <C-k>a  :Unite file_rec<CR>i
":nmap <C-k>a  :Find *
:nmap <C-k>   :Find *

:nmap <C-k>o :BufSel<Space>

:nmap f :call ShowFuncName() <CR>

" Mercurial diff (alternative use vnew)
":nmap <C-D> :r ! git diff % > %.diff<CR>:new %.diff<CR>

" Diff
:nmap <C-D> :VCSDiff<CR>

" Shift+left arrow will go one window left, etc.
:nmap <S-Up> :wincmd k<CR>
:nmap <S-Down> :wincmd j<CR>
:nmap <S-Left> :wincmd h<CR>
:nmap <S-Right> :wincmd l<CR>

" Default Colors for CursorLine
":highlight  CursorLine ctermbg=DarkCyan ctermfg=None

" Change Color when entering Insert Mode
":autocmd InsertEnter * highlight  CursorLine ctermbg=Grey ctermfg=Red

" Revert Color to default when leaving Insert Mode
":autocmd InsertLeave * highlight  CursorLine ctermbg=DarkCyan ctermfg=None

" Vimdiff colors
:highlight DiffAdd    ctermbg=Black      gui=NONE  guifg=bg  guibg=Green
" :highlight DiffAdd    ctermbg=22 gui=NONE  guifg=bg  guibg=Green
:highlight DiffDelete ctermbg=52         gui=NONE  guifg=bg  guibg=Red
:highlight DiffChange ctermbg=53         gui=NONE  guifg=bg  guibg=Yellow
":highlight DiffText   ctermbg=57         gui=NONE  guifg=bg  guibg=Magenta
:highlight DiffText   ctermbg=DarkRed gui=NONE  guifg=bg  guibg=Magenta

" Editor colors
:highlight User1 ctermfg=0   ctermbg=Yellow      guifg=#ffdad8  guibg=#880c0e
:highlight User2 ctermfg=255 ctermbg=DarkRed     guifg=#000000  guibg=#F4905C
:highlight User3 ctermfg=255 ctermbg=DarkMagenta guifg=#292b00  guibg=#f4f597
:highlight User4 ctermfg=0   ctermbg=Grey        guifg=#112605  guibg=#aefe7B
:highlight User5 ctermfg=0   ctermbg=DarkGrey    guifg=#051d00  guibg=#7dcc7d
:highlight User7 ctermfg=255 ctermbg=52          guifg=#ffffff  guibg=#880c0e gui=bold
:highlight User8 ctermfg=255 ctermbg=DarkBlue    guifg=#ffffff  guibg=#5b7fbb
:highlight User9 ctermfg=255 ctermbg=52          guifg=#ffffff  guibg=#810085
:highlight User0 ctermfg=255 ctermbg=52          guifg=#ffffff  guibg=#094afe

:highlight Search cterm=NONE ctermfg=grey ctermbg=52

" Fold
:highlight Folded      ctermfg=Blue    ctermbg=Black       guibg=Blue   guifg=DarkGrey
:highlight FoldColumn  ctermfg=White   ctermbg=DarkGrey    guibg=White  guifg=DarkGrey

" Always display the status line
:set laststatus=2
:let g:airline#extensions#tabline#enabled=1
:let g:airline#extensions#tabline#buffer_nr_show=1
:let g:airline#extensions#tabline#buffer_nr_format='%s: '
:let g:airline_left_sep =''
:let g:airline_right_sep =''
:let g:airline_detect_modified = 1
:let g:airline_theme='bubblegum'
":let g:airline_theme='base16-spacemacs'

":set statusline=
":set statusline+=%1*\ %{@/}\                               "Currently searched
":set statusline+=%4*\[%n]                                  "buffernr
"":set statusline+=%{GetCurrentMode()}\                      "File+path
":set statusline+=%0*\ %<%F\                                "File+path
":set statusline+=%5*\ %y\                                  "FileType
":set statusline+=%5*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
":set statusline+=%5*\ %{&ff}\                              "FileFormat (dos/unix..)
"":set statusline+=%5*\ %{&spelllang}\                       "Spellanguage
"":set statusline+=%1*\ %{@/}\                               "Currently searched
":set statusline+=%5*\ %=\ row:%l/%L\                       "Rownumber/total
":set statusline+=%5*\ col:%03c\                            "Column number
":set statusline+=%4*\ \ %2*\%m%4*\%r%w\ %P\ \              "Modified? Readonly? Top/bot

" Color for entering and living insert mode
:au InsertEnter * hi StatusLine ctermfg=DarkGreen ctermbg=Black
:au InsertLeave * hi StatusLine ctermfg=Grey  ctermbg=Black

" Python completion
:autocmd FileType  let g:jedi#auto_initialization = 1
:autocmd FileType python let g:jedi#auto_vim_configuration = 1
:autocmd FileType python let g:jedi#use_tabs_not_buffers = 0
:autocmd FileType python let g:jedi#use_splits_not_buffers = "bottom"
:autocmd FileType python let g:jedi#popup_on_dot = 1
:autocmd FileType python let g:jedi#popup_select_first = 0
" 0, 1 or 2 (cmd)
:autocmd FileType python let g:jedi#show_call_signatures = "0"
:autocmd FileType python let g:jedi#goto_assignments_command = "<leader>g"
:autocmd FileType python let g:jedi#goto_definitions_command = "<leader>d"
:autocmd FileType python let g:jedi#documentation_command = "K"
:autocmd FileType python let g:jedi#usages_command = "<C-u>"
:autocmd FileType python let g:jedi#completions_command = "<C-Space>"
:autocmd FileType python let g:jedi#rename_command = "<leader>r"

" <F1>

" Find the symbol under the cursor
:nmap <F2> :execute "tag " . expand("<cword>")<CR>
:nmap <F3> :execute "ptag " . expand("<cword>")<CR> " split horizontaly

" List all the changes
":nmap <F3> :changes<CR>


" Switch between source and header files (in the same folder)
:nmap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

:nmap <F5> :buffers<CR>:buffer<Space>

" Press F6 to jump to the previous method in a C++ file
:nmap <F6> ?\v^(\w+\s+)?\w+::\w+\(.*\)<CR>

:nmap <F7> <C-]>

" Open the current file with kate
:nmap <F8> :! gedit %<CR>

":nmap <F8> /\v^(\w+\s+)?\w+::\w+\(.*\)<CR>

" Toggle the file system tree
:nmap <F9> :NERDTreeToggle<CR>
:nmap <F10> :NERDTreeFind<CR>

" Toggle side bar, wich contains the list of tags
:nmap <C-F11> :TlistToggle<CR>

" Close the buffer but do not affect the splits
:nmap <F12> :BD<CR>

" Show the quickfix list
:nmap <C-Up> :botright copen<CR>
" Hide the quickfix list
:nmap <C-Down> :cclose<CR>

" Switch to the previous quickfix list results
:nmap <D-Left> :colder<CR>
" Switch to the next quickfix list results
:nmap <D-Right> :cnewer<CR>

:nmap <C-l> :botright lopen<CR>

:nmap <C-a> :Gstatus<CR>
:nmap <C-t> :Gitv<CR>

" Highlight the word under the cursor
:nmap <C-h> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


:inoremap jj <Esc>

" Completion
" :inoremap <Tab> <C-R>=CleverTab()<CR>

:set complete=.,w,b,u,t,i,d
:set completeopt-=preview
:set wildmode=full
:set wildmenu
:set expandtab

" Omni completion (not used when ycm is enabled)
:autocmd FileType python set omnifunc=pythoncomplete#Complete
:autocmd FileType c set omnifunc=ccomplete#Complete
:autocmd FileType cpp set omnifunc=omnifunc=syntaxcomplete#Complete
:autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

:let g:ycm_min_num_of_chars_for_completion = 2
:let g:ycm_error_symbol = '>>'
:let g:ycm_warning_symbol = '>~'
:let g:ycm_always_populate_location_list = 0

" ctags -R .. --sort=yes --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q
:let Tlist_Use_Right_Window = 1
:let Tlist_WinWidth = 45
:let Tlist_Show_One_File = 1
:let Tlist_Display_Prototype = 0
":let Tlist_Compact_Format = 1


" Compilation
:set makeprg=sh\ make.sh
":set errorformat+=%f:%l:\ %m
:set errorformat+=%A%f:%l:\ %m,%C%m
:noremap <C-b> :w<CR>:make!<CR><Bar>:cs reset<CR><CR>
":noremap <C-b> :w<CR>:make!<CR><Bar>:botright copen<CR>
":cc      see the current error
":cn      next error
":cp      previous error
":clist   list all errors
"botright copen


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
