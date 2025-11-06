# Vagrantfile for Ubuntu DevOps Lab with Docker, Minikube, Helm & Bridged Network
Vagrant.configure("2") do |config|
  # Base image
  config.vm.box = "ubuntu/jammy64"  # Ubuntu 22.04 LTS

  # Hostname
  config.vm.hostname = "devops-lab"

  # Networking
  ## Private network (for internal testing)
  config.vm.network "private_network", ip: "192.168.56.39"

  ## Bridged network (to connect directly to LAN/Wi-Fi)
  config.vm.network "public_network", bridge: "Wi-Fi"  # change 'Wi-Fi' to match your network adapter name if needed

  # Sync folder (Windows → Ubuntu)
  config.vm.synced_folder "D:/real-time-projects/ci-cd-microservices-aws-azure",
                          "/opt/real-time-projects/ci-cd-microservices-aws-azure",
                          type: "virtualbox"

  # VM resources
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu-devops-lab"
    vb.memory = 8192
    vb.cpus = 4
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Provisioning
  config.vm.provision "shell", inline: <<-SHELL
    echo "🚀 Updating system packages..."
    apt-get update -y && apt-get upgrade -y

    echo "🐳 Installing Docker & Docker Compose..."
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu jammy stable"
    apt-get update -y
    apt-get install -y docker-ce docker-compose

    usermod -aG docker vagrant
    systemctl enable docker
    systemctl start docker

    echo "🧰 Installing utilities..."
    apt-get install -y git python3 python3-pip vim net-tools htop

    echo "☸️ Installing Minikube & kubectl..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    dpkg -i minikube_latest_amd64.deb
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    echo "📦 Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    echo "🚦 Starting Minikube..."
    su - vagrant -c "minikube start --driver=docker --memory=4096 --cpus=2"

    echo "✅ Setup Complete! Ready for DevOps action."
  SHELL
end
