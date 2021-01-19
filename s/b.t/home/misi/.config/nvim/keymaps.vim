"the following combinations with , are taken
". - all possible stuff related to word under cursor
"l - lists
"w - windows
"b - buffers ... probably not that much necessary as I can add it to lists ...
"and the next buffer prev buffer just add to next/prev commands 
"c - commands
"/ - search
": - command prompt
"e - escape ... but would use for edit commands...
"m - misc commands like Esg Gl etc
"n - next * (anything: buffer, tab, error etc)
"p - prev * (anything)
"t - cscope (tag)
"s - :%s the word under cursor
"g - :g/ the word under the cursor and <CR>
"
":
" $HOME/.vim/keymaps/mymaps.vim

"so usage of letters
"a JUST switching between header and implementation file
"b buffers
"c commands
"d map for second commands like "do something": dg=g/<word under cursor>,"ds=:%s/ etc, etc
"e UNUSED
"f files (fc... all code, ff all files, fv .vimrc file, etc), probably the "g" will replace these"
"g go somewhere: gf, go file (but including wiki file, etc, etc.
"h used for keywoard definition/declaration/usage
"used for movement related stuff
"i UNUSED but makes lot of sense for stuf related to indexes
"j UNUSED could be used with movements related stuff (up/down)
"k UNUSED could be used with movements related stuff 
"l UNUSED could be used with movements related stuff
"m (sub)modes: for tag searching etc... TODO!!!
"n next anything following it
"o open: oo, open most related (file from all code file)... maybe f and o
"functions should be merged
"p previous anything following it
"q DO QUIT q! :q[uit]!     Quit without writing, also when visible buffers have  changes. Does not exit when there are changed hidden buffers.  Use ":qall!" to exit always.
"Q DO QUIT ALL qall!                 "
"r UNUSED registry/record???/reload
"s JUST for doing :%s/ with the word under the cursor...
"t all tag stuff...  
"u do one undo, then goback to edit mode... 
"v UNUSED unused
"w UNUSED used for windows
"x SAVE AND CLOSE current buffer 
"X SAVE AND CLOSE all buffers
""y UNUSED yank 
"z UNUSED 
"[ reserverd for [ commands, see |index.txt|

"rules:
",t, that is , followd by command grop followed by <,> should be the most used
"one

"keys with "<c-\>" this should contain class of shortcuts less used than "<c-_>"

nmap gx <Plug>(openbrowser-smart-search)

"c-l that would do escape and normal mode 
"
"
"
"first most frequently used commands
"


"to show all maps for , and ,
noremap ,    :FzfMaps<CR>
noremap ,a   :map ,a<CR>
"noremap ,b   :map ,b<CR>
noremap ,c   :map ,c<CR>
noremap ,d   :map ,d<CR>
noremap ,e   :map ,e<CR>
noremap ,f   :map ,f<CR>
noremap ,g   :map ,g<CR>
noremap ,r   :map ,r<CR>
",g family... grep 
" for stuff like :g new shortcut group is needed
"noremap ,gg   :g/<c-r><c-w><cr> 
"noremap ,gg   :grep -R <c-r><c-w> *<cr> 
"noremap ,g,   :Ag <c-r><c-w> <cr>,
"
noremap ,gb :Gblame<CR>
noremap ,gc :Gcommit<CR>
noremap ,gd :Gdiff<CR>
noremap ,gf :Gfetch<CR>
noremap ,gg :Gstatus<CR>
noremap ,gh :help fugitive<CR>
noremap ,gl :Glog<CR>
noremap ,gr :Grebase<CR>
noremap ,gw :Gwrite<CR>

noremap ,h   :map ,h<CR>
noremap <silent> ,hd   :CSearch -x declarations<CR>
noremap <silent> ,hh   :CSearch -x definitions<CR>
noremap <silent> ,hu   :CSearch -x references<CR>
noremap ,i   :map ,i<CR>
noremap ,j   :map ,j<CR>
noremap ,k   :map ,k<CR>
"lists
noremap ,l   :map ,l<CR> 
noremap ,lb  <Esc><Esc>:ls<CR>:b <space>
inoremap ,lb <Esc><Esc>:ls<CR>:b <space>
noremap <silent> ,lc  <Esc><Esc>:clist<CR>
inoremap <silent> ,lc  <Esc><Esc>:cllist<CR>
"since the lm is conflicting for maps and messages
"the shortcut could be as lma for maps and lme for messages
"as m is already taken we use k(ey) for maps
"noremap <silent> <c-_>lk  <Esc><Esc>:map<CR> 
noremap <silent> ,lf  <Esc><Esc>:fun<CR>
inoremap <silent> ,lf  <Esc><Esc>:fun<CR>
inoremap <silent> ,lk  <Esc><Esc>:map<CR>
"and l(ink) for maps
noremap ,ll  <Esc><Esc>:llist<CR>:ll<space>
inoremap ,ll  <Esc><Esc>:llist<CR>:ll<space>
noremap <silent> ,lm  <Esc><Esc>:marks<CR>
inoremap <silent> ,lm  <Esc><Esc>:marks<CR>
noremap <silent> ,lo  <Esc><Esc>:com<CR>
inoremap <silent> ,lo  <Esc><Esc>:com<CR>
noremap <silent> ,lj <Esc><Esc>:jumps<CR>
inoremap <silent> ,lj  <Esc><Esc>:jumps<CR>

noremap ,m   :map ,m<CR>
noremap ,n   :map ,n<CR>
noremap ,o   :map ,o<CR>
noremap ,t   :map ,t<CR>
noremap ,t   :map ,t<cr>
noremap ,u   :map ,u<cr>
noremap ,v   :map ,v<cr>
noremap ,w   :map ,w<cr>
noremap ,z   :map ,z<cr>


noremap ,dd   :DBExecSQLUnderCursor<CR>
noremap ,dv   :DBExecVisualSQL<CR>


noremap ,,   :
inoremap ,, <ESC>:


noremap ,s <Esc>:w<cr>
noremap ,w <c-w>
"noremap ,w <c-w>
"noremap ,wo <c-w>o
"noremap ,ws <c-w>s
"noremap ,wv <c-w>v
"noremap ,wj <c-w>j
"noremap ,wk <c-w>k
"noremap ,wl <c-w>l
"noremap ,wh <c-w>h
"noremap ,wt <c-w>t
"noremap ,wb <c-w>b

"todo: mru for tags file
"mru for all files in git

noremap ,ra :FzfAg <space>
noremap ,rf :FzfFiles<CR>

noremap ,rr  :FzfHistory<CR>
noremap ,r: :FzfHistory:<CR>
noremap ,r/ :FzfHistory/<CR>


"noremap ,.  :UCG<CR>
noremap ,ru :UCG<CR>  

noremap ,. :FzfAg <c-r><c-w><CR>  
noremap ,.h :Search <c-r><c-w><CR>

noremap ,rgc :FzfCommits<CR>
noremap ,rgf :FzfGFiles<CR>
noremap ,rg? :FzfGFiles<CR>

noremap ,rw :FzfWindows<CR>
noremap ,rh :FzfHelptags<CR>

"noremap ,rm :FzfMaps<CR>
noremap ,rm :FzfMarks<CR>

noremap ,rt :FzfTags<CR>

"inside lines
noremap ,rb :FzfLines<CR>
"noremap 'rl :FzfLines<CR> does not work, Lines is from fzf.vim
"using ag

"this is my plugin based on Ag from fzf
"TODO this is not the best mapping
",r is a class of mappings for staff than needs to be searched for
"UCG needs a word to search 
"should defined a cluss of shortcuts that are word specific
"search for word in tags
"search for word in files
"search for word in database
"search for word in syscodes


noremap ,rl :FzfBuffers<CR> 


noremap ,cq  :q!<CR> 
noremap ,q  :q!<CR> 

noremap ,Q  :q!<CR> 

"project related files
noremap ,fd  :split $ELMI_PRJ_ROOT \| setlocal nomodifiable <CR>/
noremap ,ff  :split $ELMI_CPP_FILES  \| setlocal nomodifiable <CR>/
noremap ,fr  :split $ELMI_REST_FILES \| setlocal nomodifiable <CR>/
noremap ,fj  :split $ELMI_JAVA_FILES \| setlocal nomodifiable <CR>/
noremap ,fl  :split /home/elmi/w/l.w \| setlocal nomodifiable <CR>/
noremap ,fa  :split `frp`/a.acpp \| setlocal nomodifiable <CR>/
noremap ,f2s  :split $ALT_ALLSRC_FILE \| setlocal nomodifiable <CR>/

noremap ,ft  :split $HTAGSFILE \| setlocal nomodifiable <CR>/

"open current direcotry
noremap ,fc  :split .<CR>


noremap ,cx :x<CR>
noremap ,x :x<CR>

noremap ,cX :xa<CR>
noremap ,X :xa<CR>

noremap ,<space> :


noremap <c-_>ed i<C-R>=strftime("%y-%m-%d")<CR>

inoremap <c-_>ed <C-R>=strftime("%y-%m-%d")<CR> 

"switch header/implementation file
inoremap <c-_>a <ESC><ESC>:A<CR>
noremap <c-_>a :A<CR>

inoremap <c-_>ca <ESC><ESC>:A<CR>
noremap <c-_>ca :A<CR>

"b
"noremap  <c-_>B B
"inoremap <c-_>B <Esc>B

noremap <c-_>bn :bnext<CR>
noremap <c-_>bp :bprev<CR>
noremap <c-_>bd :bdel<CR>
"version that deletes without saving 
noremap <c-_>bl :blast<CR>
noremap <c-_>bf :bfirst<CR>
noremap <c-_>bm :bmod<CR>
noremap <c-_>bb :ls<CR>:b 
noremap <c-_>br :brewind<CR>
noremap <c-_>bw :w<CR>
noremap <c-_>bb  :ls<CR>:b 


inoremap <c-_>bn <ESC><ESC>:bnext<CR>
"there should be some help in the future....
inoremap <c-_>bp <ESC><ESC>:bprev<CR>
inoremap <c-_>bd <ESC><ESC>:bdel<CR>
inoremap <c-_>bl <ESC><ESC>:blast<CR>
inoremap <c-_>bf <ESC><ESC>:bfirst<CR>
inoremap <c-_>bm <ESC><ESC>:bmod<CR>
inoremap <c-_>bb <ESC><ESC>:ls<CR>:b 
inoremap <c-_>br <ESC><ESC>:rewind<CR>
inoremap <c-_>bw <ESC><ESC>:w<CR>
inoremap <c-_>bb  <ESC><ESC>:ls<CR>:b 

"c"
noremap <c-_>c  <Esc><Esc>:map <lt>c-_>c<CR>
inoremap <c-_>c  <Esc><Esc>:map <lt>c-_>c<CR>

noremap  <c-_>c<c-p> :<c-p>
inoremap  <c-_>c<c-p> <ESC><ESC>:<c-p>

noremap  <c-_>c<c-n> :<c-n>
inoremap  <c-_>c<c-n> <ESC><ESC>:<c-n>

noremap <silent> <c-_>cw  <Esc><Esc>:w<CR>
inoremap <silent> <c-_>cw  <Esc><Esc>:w<CR>

noremap <c-_>cg h:grep <c-r><c-w>
inoremap <c-_>cg  <Esc><Esc>h:grep <c-r><c-w>

"noremap <silent> <c-_>cccq  :qa!<CR>
"inoremap <silent> <c-_>cccq  <Esc><Esc>:qa!<CR>

noremap <silent> <c-_>cq  :qa!<CR>
inoremap <silent> <c-_>cq  <Esc><Esc>:qa!<CR>

noremap <silent> <c-_>cm  :make!<CR>
inoremap <silent> <c-_>cm  <Esc><Esc>:make!<CR>


let g:mode="n"

function! Bmode()
   map <c-n> :bnext<CR>
   map <c-p> :bprev<CR>
endfunction 

function! Cmode()
   map <c-n> :cnext<CR>
   map <c-p> :cprev<CR>
endfunction 

function! Lmode()
   map <c-n> :lnext<CR>
   map <c-p> :lprev<CR>
endfunction 

function! Tmode()
   map <c-n> :tabnext<CR>
   map <c-p> :tabprev<CR>
endfunction 

function! Nmode()
   map <c-n> :lnext<CR>
   map <c-p> :lprev<CR>
endfunction 

function! Dmode()
   map <c-n> ]c
   map <c-p> [c
endfunction 

function! Smode()
   map <c-n> ]s
   map <c-p> [s
endfunction 

function! Mmode()
   map <c-n> ]s
   map <c-p> [s
endfunction 

function! Gmode()
   map <c-n> <Plug>GitGutterNextHunk
   map <c-p> <Plug>GitGutterPrevHunk
endfunction 

call Cmode()
   
noremap ,jt :call Tmode()<CR>
noremap ,mt :call Tmode()<CR>

noremap ,jb :call Bmode()<CR>
noremap ,mb :call Bmode()<CR>

noremap ,jc :call Cmode()<CR>
noremap ,mc :call Cmode()<CR>

noremap ,jl :call Lmode()<CR>
noremap ,ml :call Lmode()<CR>

noremap ,jd :call Dmode()<CR>
noremap ,md :call Dmode()<CR>

noremap ,js :call Smode()<CR>
noremap ,ms :call Smode()<CR>

noremap ,mm :call Mmode()<CR>

noremap ,mn :call Nmode()<CR>


noremap ,mg :call Gmode()<CR>


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

   """"""""""""" My cscope/vim key mappings
   "
   " The following maps all invoke one of the following cscope search types:
   "
   "   's'   symbol: find all references to the token under cursor
   "   
   "   'g'   global: find global definition(s) of the token under cursor
   "   'c'   calls:  find all calls to the function name under cursor
   "   't'   text:   find all instances of the text under cursor
   "   'e'   egrep:  egrep search for the word under cursor
   "   'f'   file:   open the filename under cursor
   "   'i'   includes: find files that include the filename under cursor
   "   'd'   called: find functions that function under cursor calls
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

   nmap ,i :map ,i<CR>
   nmap ,ii :cs find s <cword><CR>
   nmap ,is :cs find s <cword><CR>
   nmap ,ig :cs find g <cword><CR>
   nmap ,ic :cs find c <cword><CR>
   nmap ,it :cs find t <cword><CR>
   nmap ,ie :cs find e <cword><CR>
   nmap ,if :cs find f <cword><CR>
   nmap ,ii :cs find i <cword><CR>
   nmap ,id :cs find d <cword><CR>


endif

noremap ,ui :call rtags#SymbolInfo()<CR>
noremap ,uj :call rtags#JumpTo()<CR>
noremap ,uS :call rtags#JumpTo(" ")<CR>
noremap ,uV :call rtags#JumpTo("vert")<CR>
noremap ,uT :call rtags#JumpTo("tab")<CR>
noremap ,up :call rtags#JumpToParent()<CR>
noremap ,uf :call rtags#FindRefs()<CR>
noremap ,un :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,utags#CompleteSymbols")<CR>
noremap ,us :call rtags#FindSymbols(input("Pattern? ", "", "customlist,utags#CompleteSymbols"))<CR>
noremap ,ur :call rtags#ReindexFile()<CR>
noremap ,ul :call rtags#ProjectList()<CR>
noremap ,uw :call rtags#RenameSymbolUnderCursor()<CR>
noremap ,uv :call rtags#FindVirtuals()<CR>
noremap 6 :call rtags#CompleteAtCursor()<CR>

"TODO find a solution for insterting special characters
"imap ;a <C-V>u00e4
"imap ;o <C-V>u00f6
"imap ;e <C-V>u00fc
"imap ;u <C-V>u00fc
"imap ;i <C-V>u00ef
"imap ;A <C-V>u00c4
"imap ;O <C-V>u00d6
"imap ;E <C-V>u00cb
"imap ;U <C-V>u00dc
"imap ;I <C-V>u00cf


"
"imap :a <C-V>u00e4
"imap :o <C-V>u00f6
"imap :e <C-V>u00fc
"imap :u <C-V>u00fc
"imap :i <C-V>u00ef
"imap :A <C-V>u00c4
"imap :O <C-V>u00d6
"imap :E <C-V>u00cb
"imap :U <C-V>u00dc
"imap :I <C-V>u00cf


"
""imap "a <C-V>u00
"imap "o <C-V>u0151
""imap "e <C-V>u0
"imap "u <C-V>u0171
""imap "i <C-V>u0
""imap "A <C-V>u00
"imap "O <C-V>u0150
""imap "E <C-V>u00
"imap "U <C-V>u0170
""imap "I <C-V>u00
"
"imap 'a <C-V>u00e1
"imap 'o <C-V>u00f3
"imap 'e <C-V>u00e9
"imap 'u <C-V>u00fa
"imap 'i <C-V>u00ed
"imap 'A <C-V>u00c1
"imap 'O <C-V>u00d3
"imap 'E <C-V>u00c9
"imap 'U <C-V>u00da
"imap 'I <C-V>u00cd

" CTRL-A is Select all
"noremap <C-A> gggH<C-O>G
"inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-A> <C-C>gggH<C-O>G
" CTRL-F4 is Close window
"noremap <C-F4> <C-W>c
"inoremap <C-F4> <C-O><C-W>c
"cnoremap <C-F4> <C-C><C-W>c
"CTRL-Tab is Next window

