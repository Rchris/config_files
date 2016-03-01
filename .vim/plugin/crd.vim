


"
" Grep a user input patern in a specific folder
"
function! GrepPaternFolder(patern, folder)
  echo "grep folder: '".a:patern."' in ".a:folder."/"
  execute "grep! --color=auto -rin \"".a:patern."\" ".a:folder."/** "
  copen
endfunction
command! -nargs=+ -complete=dir GrepPaternFolder :call GrepPaternFolder(<f-args>)


"
" Grep the patern under the cursor in a specific folder
"
function! GrepFolder(folder)
  execute "grep! --color=auto -rin \"". expand("<cword>") ."\" ".a:folder."/** "
  copen
endfunction
command! -nargs=1 -complete=dir GrepFolder :call GrepFolder("<args>")


"
" Find file in current directory and edit it
"
function! Find(name)
  let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'")
  " Replace above line with below one for gvim on windows
  "let l:list=system("find . -name ".a:name." | perl -ne \"print qq{$.\\t$_}\"")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  " Open the file
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")


"
" Switch to an other buffer using a patern
"
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers
  endif
endfunction
"Bind the BufSel() function to a user-command
command! -nargs=1 -complete=buffer BufSel :call BufSel("<args>")


"
" Print the current fucntion name
"
function! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  "echohl Function
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfunction


"""""""""""""""""""" AUTOCOMPLETION WITH THE TAB KEY
" It works like this:
" "   - If the line is empty (only spaces) insert a tab (but not the tab
" "     character, but spaces instead)
" "   - If the line is not empty, use autocompletion.
" "   - Choose from all the available options/matches with Tab and Shift+Tab
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction


