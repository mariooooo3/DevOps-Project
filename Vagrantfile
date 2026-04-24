Vagrant.configure("2") do |config|
  config.vm.box = "generic/rocky9"

  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = false
  end

  # --------------------------------------------------
  # APP2
  # --------------------------------------------------
  config.vm.define "app2" do |app_config|
    app_config.vm.hostname = "app.fiipractic.lan"
    app_config.vm.network "private_network", ip: "192.168.56.30"

    app_config.vm.provider "virtualbox" do |vb|
      vb.name = "FiiPractic-App2"
      vb.memory = 2048
      vb.cpus = 2
    end

    app_config.vm.provision "shell", inline: <<-SHELL
      set -e

      echo "nameserver 8.8.8.8" > /etc/resolv.conf
      echo "nameserver 1.1.1.1" >> /etc/resolv.conf

      echo "root:fiipractic" | chpasswd

      sed -i 's/^#\\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -i 's/^#\\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

      systemctl restart sshd

      dnf config-manager --set-disabled epel || true
      dnf clean all || true
      dnf makecache || true

      dnf install -y git vim dnf-plugins-core
      dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo || true
      dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
      systemctl enable --now docker

      grep -q "192.168.56.30 app.fiipractic.lan" /etc/hosts || echo "192.168.56.30 app.fiipractic.lan" >> /etc/hosts
      grep -q "192.168.56.40 gitlab.fiipractic.lan" /etc/hosts || echo "192.168.56.40 gitlab.fiipractic.lan" >> /etc/hosts
    SHELL
  end

  # --------------------------------------------------
  # GITLAB2
  # --------------------------------------------------
  config.vm.define "gitlab2" do |gitlab_config|
    gitlab_config.vm.hostname = "gitlab.fiipractic.lan"
    gitlab_config.vm.network "private_network", ip: "192.168.56.40"

    gitlab_config.vm.provider "virtualbox" do |vb|
      vb.name = "FiiPractic-GitLab2"
      vb.memory = 6144
      vb.cpus = 4
    end

    gitlab_config.vm.disk :disk, size: "30GB", primary: true

    gitlab_config.vm.provision "file", source: "gitlab-ce.repo", destination: "/tmp/gitlab-ce.repo"
    gitlab_config.vm.provision "file", source: "gitlab-runner.repo", destination: "/tmp/gitlab-runner.repo"

    gitlab_config.vm.provision "shell", inline: <<-SHELL
      set -e

      echo "nameserver 8.8.8.8" > /etc/resolv.conf
      echo "nameserver 1.1.1.1" >> /etc/resolv.conf

      echo "root:fiipractic" | chpasswd

      sed -i 's/^#\\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -i 's/^#\\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

      systemctl restart sshd

      dnf clean all || true
      dnf makecache || true

      dnf install -y git vim epel-release dnf-plugins-core
      dnf install -y ansible

      dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo || true
      dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
      systemctl enable --now docker

      cp /tmp/gitlab-ce.repo /etc/yum.repos.d/gitlab-ce.repo
      cp /tmp/gitlab-runner.repo /etc/yum.repos.d/gitlab-runner.repo

      grep -q "192.168.56.30 app.fiipractic.lan" /etc/hosts || echo "192.168.56.30 app.fiipractic.lan" >> /etc/hosts
      grep -q "192.168.56.40 gitlab.fiipractic.lan" /etc/hosts || echo "192.168.56.40 gitlab.fiipractic.lan" >> /etc/hosts
    SHELL
  end
end