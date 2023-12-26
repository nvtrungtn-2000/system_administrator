#!/bin/bash
[ $EUID -eq 0 ] && echo "Bạn đã đăng nhập bằng quyền root." || echo "Bạn chưa đăng nhập bằng quyền root."