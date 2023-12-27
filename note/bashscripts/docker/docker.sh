#!/bin/bash
[ $EUID -eq 0 ] && echo "Bạn đã đăng nhập bằng quyền root." || echo "Bạn chưa đăng nhập bằng quyền root."

required_packages=("apt-transport-https" "ca-certificates" "curl" "gnupg" "lsb-release" "nano" "firewalld" "gnupg-agent" "software-properties-common")

function update_and_upgrade() {
    sudo apt-get update -y && sudo apt-get upgrade -y
}

function check_and_install_package() {
    package_name=$1
    if ! dpkg -l | grep -q $package_name; then
        echo "Gói $package_name chưa tồn tại, đang cài đặt..."
        if sudo apt-get install -y $package_name &>/dev/null; then
            echo "Gói $package_name đã được cài đặt thành công."
        else
            echo "Có lỗi xảy ra trong quá trình cài đặt gói $package_name."
        fi
    else
        echo "Gói $package_name đã tồn tại."
    fi
}

for package in "${required_packages[@]}"; do
    check_and_install_package $package
done

function install_docker() {
    if docker --version &>/dev/null; then
        echo "Docker đã được cài đặt. Bỏ qua quá trình cài đặt."
    else
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg -
        echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        update_and_upgrade
        sudo apt-get install docker-ce docker-ce-cli containerd.io -y

        if sudo systemctl status docker &>/dev/null; then
            echo "Docker đã được cài đặt thành công."
            sudo groupadd docker
            sudo usermod -aG docker $USER
            sudo systemctl status docker
            docker --version
        else
            echo "Có lỗi xảy ra trong quá trình cài đặt Docker."
        fi
    fi
}
update_and_upgrade
install_docker
