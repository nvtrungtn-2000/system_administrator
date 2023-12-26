[ "$(whoami)" == "root" ] && echo "Bạn đã đăng nhập bằng quyền root." || echo "Bạn chưa đăng nhập bằng quyền root."

required_packages=("apt-transport-https", "ca-certificates", "curl", "gnupg", "lsb-release", "nano", "firewalld", "gnupg-agent", "software-properties-common")
install_packages=()

update_and_upgrade() {
    sudo apt-get update -y && sudo apt-get upgrade -y
}

check_and_add_to_install() {
  package_name=$1
  if ! dpkg -l | grep -q $package_name; then
    B+=("$package_name")
  fi
}
for package in "$required_packages{[@]}"; do
  check_and_add_to_install $package
done

if [ ${#install_packages[@]} -gt 0 ]; then
  sudo apt-get install -y "${install_packages[@]}"
fi

install_docker() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    update_and_upgrade
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    sudo systemctl status docker && docker --version
}

update_and_upgrade
install_docker