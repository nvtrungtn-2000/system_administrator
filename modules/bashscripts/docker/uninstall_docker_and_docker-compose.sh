#!/bin/bash
[ $EUID -eq 0 ] && echo "Bạn đã đăng nhập bằng quyền root." || { echo "Bạn cần đăng nhập bằng quyền root để chạy script."; exit 1; }

function uninstall_docker() {
    echo "Bạn đang chạy chương trình gỡ Docker."
    
    if ! command -v docker &> /dev/null; then
        echo "Docker chưa được cài đặt."
        return
    fi
    
    docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
    sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
    echo "Đã gỡ Docker thành công."
}

function uninstall_docker_compose() {
    echo "Bạn đang chạy chương trình gỡ Docker Compose."
    
    if [ ! -f /usr/local/bin/docker-compose ]; then
        echo "Docker Compose chưa được cài đặt."
        return
    fi
    
    sudo rm /usr/local/bin/docker-compose
    echo "Đã gỡ Docker Compose thành công."
}
while true; do
    echo "-------------------------------------------------------"
    echo "Bạn đang chạy chương trình gỡ docker và docker-compose."
    echo "Vui lòng chọn option tương ứng:"
    echo "1. Gỡ docker"
    echo "2. Gỡ docker-compose"
    echo "3. Gỡ docker và docker-compose"
    echo "4. Không thực hiện"
    echo "-------------------------------------------------------"
    read option

    if [ "$option" == "1" ]; then
        uninstall_docker
    elif [ "$option" == "2" ]; then
        uninstall_docker_compose
    elif [ "$option" == "3" ]; then
        uninstall_docker
        uninstall_docker_compose
    elif [ "$option" == "4" ]; then
        echo "Bạn đã chọn hủy. Không có thao tác nào được thực hiện."
    else
        echo "Option không hợp lệ"
    fi
done
