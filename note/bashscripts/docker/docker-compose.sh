#!/bin/bash
[ $EUID -eq 0 ] && echo "Bạn đã đăng nhập bằng quyền root." || echo "Bạn chưa đăng nhập bằng quyền root."

if sudo systemctl status docker &>/dev/null; then
    echo "Docker đã được cài đặt thành công."
    docker --version
else
    wget https://raw.githubusercontent.com/nvtrungtn-2000/system_administrator/main/note/bashscripts/docker/docker.sh
    if [[ -f $file_path ]]; then
        chmod +x docker.sh
        ./docker.sh
    else
        echo "Không tìm thấy file docker.sh. Vui lòng kiểm tra lại!"
    fi
fi

install_docker_compose() {
    if docker-compose --version &>/dev/null; then
        echo "Docker Compose đã được cài đặt. Bỏ qua quá trình cài đặt."
        docker-compose --version
        return
    fi
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    if docker-compose --version &>/dev/null; then
        echo "Docker Compose đã được cài đặt thành công."
        docker-compose --version
    else
        echo "Có lỗi xảy ra trong quá trình cài đặt Docker Compose."
    fi
}
install_docker_compose