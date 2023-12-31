#!/bin/bash

update_and_upgrade() {
    sudo apt-get update -y && sudo apt-get upgrade -y > /dev/null
    echo "Đang thực hiện cập nhật hệ thống, ..."
}

install_basic_packages() {
    required_packages=("firewalld" "nano" "wget")

    for required_package in "$required_packages[@]"; do
        echo "[INF] Đang cài đặt gói "$required_package", ..."
        sudo apt-get install "$required_package" -y > /dev/null
    done

}

install_asterisk() {
    update_and_upgrade && install_basic_packages
    configure_allow_ports=("50668/udp" "55038/tcp")

    for configure_allow_port in "${configure_allow_ports[@]}"; do
        sudo firewall-cmd --zone=public --add-port="$configure_allow_port" --permanent > /dev/null
    done
    sudo firewall-cmd --reload > /dev/null

    required_packages=()
}

configure_asterisk() {
    
}