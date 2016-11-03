" cscope -b -q -R -Iinclude -ssrc -slibnm-glib -slibnm-util -smarshallers -scli/src;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate
	
	" Use quickfix pane
	set cscopequickfix=s-,c-,d-,i-,t-,e-

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that call the function under cursor
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "


    nmap <C-\>s :execute "cs find s " . expand("<cword>") <Bar> copen<CR>	
    nmap <C-\>g :execute "cs find g " . expand("<cword>") <Bar> copen<CR>	
    nmap <C-\>c :execute "cs find c " . expand("<cword>") <Bar> copen<CR>	
    nmap <C-\>t :execute "cs find t " . expand("<cword>") <Bar> copen<CR>	
    nmap <C-\>e :execute "cs find e " . expand("<cword>") <Bar> copen<CR>	
    nmap <C-\>f :execute "cs find f " . expand("<cfile>") <CR>	
    nmap <C-\>i :execute "cs find i " . expand("<cfile>") <Bar> copen<CR>	
    nmap <C-\>d :execute "cs find d " . expand("<cword>") <Bar> copen<CR>	
"    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	
    
	nmap <C-@>s :execute "scs find s " . expand("<cword>") <Bar> copen<CR>	
	nmap <C-@>g :execute "scs find g " . expand("<cword>") <Bar> copen<CR>	
	nmap <C-@>c :execute "scs find c " . expand("<cword>") <Bar> copen<CR>	
	nmap <C-@>t :execute "scs find t " . expand("<cword>") <Bar> copen<CR>	
	nmap <C-@>e :execute "scs find e " . expand("<cword>") <Bar> copen<CR>	
	nmap <C-@>f :execute "scs find f " . expand("<cfile>") <CR>	
	nmap <C-@>i :execute "scs find i " . expand("<cfile>") <Bar> copen<CR>	
	nmap <C-@>d :execute "scs find d " . expand("<cword>") <Bar> copen<CR>	
"    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :execute "vert scs find s " . expand("<cword>") <Bar> copen<CR>
    nmap <C-@><C-@>g :execute "vert scs find g " . expand("<cword>") <Bar> copen<CR>
    nmap <C-@><C-@>c :execute "vert scs find c " . expand("<cword>") <Bar> copen<CR>
    nmap <C-@><C-@>t :execute "vert scs find t " . expand("<cword>") <Bar> copen<CR>
    nmap <C-@><C-@>e :execute "vert scs find e " . expand("<cword>") <Bar> copen<CR>
    nmap <C-@><C-@>f :execute "vert scs find f " . expand("<cfile>") <CR>	
    nmap <C-@><C-@>i :execute "vert scs find i " . expand("<cfile>") <Bar> copen<CR>	
    nmap <C-@><C-@>d :execute "vert scs find d " . expand("<cword>") <Bar> copen<CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif