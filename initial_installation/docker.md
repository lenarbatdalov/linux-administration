# Docker and docker compose
### [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
```zsh
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

### [docker compose](https://docs.docker.com/compose/install/compose-plugin/#installing-compose-on-linux-systems)
```zsh
sudo apt-get update
sudo apt-get install docker-compose-plugin

docker compose version
```

### allow
```zsh
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod a+rwx /var/run/docker.sock
sudo chmod a+rwx /var/run/docker.pid
```
