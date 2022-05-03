# [Статья с digitalocean](https://www.digitalocean.com/community/tutorials/how-to-install-go-and-set-up-a-local-programming-environment-on-ubuntu-18-04-ru)
```
wget https://dl.google.com/go/go1.18.1.linux-amd64.tar.gz
sha256sum go1.18.1.linux-amd64.tar.gz
sudo tar -xvf go1.18.1.linux-amd64.tar.gz -C /usr/local
sudo chown -R root:root /usr/local/go
mkdir -p $HOME/go/{bin,src}

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

go version
```
