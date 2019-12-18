#!/usr/bin/env bash


install_dir=$HOME/.config/main.dotz

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
    mkdir -p $install_dir/s$(dirname $what)
    cp -r s$what $install_dir/s$what

    [ -f $what ] && rm $what

    
    if [ $link -eq 1 ]; then
	echo "creating symlink ln -s s$what $install_dir/s$what $what"
        ln -s $install_dir/s$what $what
	
    fi

}

prepare() {
    
    if [ -d $install_dir ]; then 
        mv $install_dir $HOME/.config/main.dotz.$(date +%Y.%m.%d.%H.%M.%S)
    fi

    mkdir -p $install_dir/s #'system'
    mkdir -p $install_dir/r #'rest', external stuff
}

install_ohmyzsh() {
    #TODO: make a copy of ohmyzsh with a fixed branch
    
    ohmyzsh_commit=7dddfe0a39b75acbe265c47b6d1dc575d6dedd9f
    mkdir -p $install_dir/r
    echo downloading https://github.com/ohmyzsh/ohmyzsh/archive/$ohmyzsh_commit.zip 
    echo https://github.com/ohmyzsh/ohmyzsh/archive/$ohmyzsh_commit.zip $install_dir/r/$ohmyzsh_commit.zip
    curl -L https://github.com/ohmyzsh/ohmyzsh/archive/$ohmyzsh_commit.zip -o $install_dir/r/$ohmyzsh_commit.zip
    unzip -q $install_dir/r/$ohmyzsh_commit -d $install_dir/r

    mv $install_dir/r/ohmyzsh-$ohmyzsh_commit $install_dir/r/ohmyzsh
    install_component /home/misi/.ohmyzsh

}
install() {
    install_component --link /home/misi/.zshrc
    install_component --link /home/misi/.config/nvim
    install_component --link /home/misi/.tmux.conf
    install_component --link /home/misi/.ion3
    
    install_ohmyzsh
}

prepare
install
