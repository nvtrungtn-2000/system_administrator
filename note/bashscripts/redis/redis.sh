#!/bin/bash
[ $EUID -eq 0 ] && echo "Bạn đã đăng nhập bằng quyền root." || { echo "Bạn chưa đăng nhập bằng quyền root."; exit 1; }

function install_redis() {

}

function configure_redis() {

}

install_redis
configure_redis
