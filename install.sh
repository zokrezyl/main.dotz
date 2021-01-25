#!/usr/bin/env bash

set -e
set -x


trap 'catch' ERR
catch() {
  echo "An error has occurred but we're going to eat it!!"
}

install_dir=$HOME/.config/main.dotz
install_dir_b_t=$install_dir/s/b.t #install dir for basic stuff
src_home_dir=$(dirname $(realpath $0))
src_home_dir_b_t=$src_home_dir/s/b.t/HOME

install_component() {

    link=0
    what=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            --link)
                shift
                link=1
                ;;
            *)
                what=$1
                shift
                break
                ;;
        esac
    done

    echo "installing $what"
    what_dirname=$(dirname $what)
    echo "what_dirname: $what_dirname"
    [ "$what_dirname" == "." ] || mkdir -p $install_dir_b_t/$what_dirname
    cp -r $src_home_dir_b_t/$what $install_dir_b_t/$what

    if [ $link -eq 1 ]; then
	    echo "creating symlink ln -s $install_dir_b_t$what $what"
        [ -L $HOME/$what ] && rm $HOME/$what
        ln -s $install_dir_b_t/$what $HOME/$what
	
    fi

}

prepare() {
    
    if [ -d $install_dir ]; then 
        mv $install_dir $HOME/.config/main.dotz.$(date +%Y.%m.%d.%H.%M.%S)
    fi

    mkdir -p $install_dir_b_t #'system'
    #mkdir -p $install_dir_e_t #'rest', external stuff
}

install_ohmyzsh() {
    #TODO: make a copy of ohmyzsh with a fixed branch
    
    ohmyzsh_commit=7dddfe0a39b75acbe265c47b6d1dc575d6dedd9f
    echo downloading https://github.com/ohmyzsh/ohmyzsh/archive/$ohmyzsh_commit.zip 
    echo https://github.com/ohmyzsh/ohmyzsh/archive/$ohmyzsh_commit.zip $install_dir_b_t/$ohmyzsh_commit.zip
    curl -L https://github.com/ohmyzsh/ohmyzsh/archive/$ohmyzsh_commit.zip -o $install_dir_b_t/$ohmyzsh_commit.zip
    unzip -q $install_dir_b_t/$ohmyzsh_commit -d $install_dir_b_t

    mv $install_dir_b_t/ohmyzsh-$ohmyzsh_commit $install_dir_b_t/ohmyzsh
    install_component --link .ohmyzsh

}
install() {
    install_component --link .zshrc
    install_component --link .config/nvim
    install_component --link .tmux.conf
    install_component --link .notion
    
    install_ohmyzsh
}

prepare
install
