fbr1() {
    local branches branch
        branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fbr - checkout git branch (including remote branches)
fbr2() {
    local branches branch
        branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
                fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
    local branches branch
        branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
        branch=$(echo "$branches" |
                fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
    local tags branches target
        tags=$(
                git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
        branches=$(
                git branch --all | grep -v HEAD             |
                sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
                sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
        target=$(
                (echo "$tags"; echo "$branches") |
                fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
        git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always %'" \
             --bind "enter:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}




# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}


# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

# In tmux.conf
# bind-key 0 run "tmux split-window -l 12 'bash -ci ftpane'"

c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 2 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Profile 1/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}


# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}


# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}
# GIT heart FZF
# -------------

#https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
#https://junegunn.kr/2016/07/fzf-git/

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gs() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

unalias gb
gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -$LINES'
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -$LINES'|
  grep -o "[a-f0-9]\{7,\}"
}

unalias gr
gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -$LINES' |
  cut -d$'\t' -f1
}
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper
#!/bin/zsh

#rule... for 'read only' commands one letter
#for write (commit etc.) 
alias $ALIAS_FLAGS ga='wrgit add'
#alias $ALIAS_FLAGS gb='wrgit branch'
alias $ALIAS_FLAGS gbr='wrgit branch'
alias $ALIAS_FLAGS gbra='wrgit branch'
alias $ALIAS_FLAGS gd='wrgit diff'
alias $ALIAS_FLAGS gg='wrgit grep'
#alias $ALIAS_FLAGS gh='wrgit help'
#alias $ALIAS_FLAGS gil='_fzf_ git log'
alias $ALIAS_FLAGS gl='git log| fzf --preview'
alias $ALIAS_FLAGS gll='git log --graph --oneline --all --color=always| fzf --ansi --preview'
#alias $ALIAS_FLAGS gs='wrgit status'
alias $ALIAS_FLAGS gst='wrgit status'
alias $ALIAS_FLAGS gsh='wrgit show'
#alias $ALIAS_FLAGS gf='wrgit fetch'
alias $ALIAS_FLAGS gfe='wrgit fetch'
alias $ALIAS_FLAGS gc='wrgit config -l'
alias $ALIAS_FLAGS gc='wrgit config'
alias $ALIAS_FLAGS gice='wrgit config -e'
alias $ALIAS_FLAGS gicm='wrgit commit'
alias $ALIAS_FLAGS gico='wrgit checkout'
alias $ALIAS_FLAGS gip='wrgit push'
alias $ALIAS_FLAGS gips='wrgit push'
alias $ALIAS_FLAGS gipl='wrgit pull'
alias $ALIAS_FLAGS gime='wrgit merge'
alias $ALIAS_FLAGS gim='wrgit merge'
alias $ALIAS_FLAGS gir='wrgit remote -v'
alias $ALIAS_FLAGS girt='wrgit remote'
alias $ALIAS_FLAGS girem='wrgit remote'
alias $ALIAS_FLAGS girs='wrgit reset'
alias $ALIAS_FLAGS gires='wrgit reset'

alias $ALIAS_FLAGS gik='gitk'

#!/bin/sh


#TODO ... idea: search in each directory for some ".prj" file for settings and source it 
#before sourcing it check for some "security" key inside

chpwd() {
#TODO ... check if inside screen..
     #echo -ne "\033]0;`hostname`:`echo \[$ACTIVEVIEWSHORT\]``pwd`\007"
     #print -Pn "\033]0; %m $ACTIVEVIEWSHORT %~\007"
     #tcpclient -q dhws035 12345  sh -c 'exec ls  >&7'
     #ls
     #tcpclient -q dhws035 12345  sh -c 'exec echo --$HOSTNAME:$PWD--  >&7'
     print -Pn "\033]0; %m %~\007"
     export CUCU=$PWD
     ls
     print "<$PWD>"
     #tmux refresh-client
	 MSG="$PWD|%m/%d|%H:%M"
	 tmux setw status-right $MSG
	 #tmux display-message $PWD


}

precmd() {
     print -Pn "\033]0; %m %~\007"

}

_fzf_() {

	$@ | fzf --ansi

}





# v - open files in ~/.viminfo
v() {
	#TODO .. if parameter specified, then open that file
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim -o ${files//\~/$HOME}
}

#. /home/elmi/s/b.t/bin/z
#. /home/elmi/s/b.t/bin/fasd
. $SYSTEMS_BUSE_TXT_ROOT_DIR/bin/fasd

#eval "$(fasd --init posix-alias zsh-hook)"

#unalias z 2> /dev/null

cccc() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}


# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}


# b - browse chrome bookmarks
b() {
     bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks
     bookmarks_path="$HOME/.config/google-chrome/Default/Bookmarks"

     jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r "$jq_script" < "$bookmarks_path" \
        | grep 'google interview' \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf --ansi \
        | cut -d$'\t' -f2 \
        | xargs xdg-open
}

__d() {
  local DIR
  #DIR=$(fasd -d | sort -g | fzf +s +m) && cd $(sed 's/^[0-9.]* *//' <<< "$DIR")
  DIR=$(fasd -d | sort -g | fzf ) && cd $(sed 's/^[0-9.]* *//' <<< "$DIR")
}
function  mans(){
    man -k . | fzf -n1,2 --preview "echo {} | cut -d' ' -f1 | sed 's# (#.#' | sed 's#)##' | xargs -I% man %" --bind "enter:execute: (echo {} | cut -d' ' -f1 | sed 's# (#.#' | sed 's#)##' | xargs -I% man % | less -R)"

}
