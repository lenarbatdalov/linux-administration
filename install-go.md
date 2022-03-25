# best
```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go

go env -w GO111MODULE=auto
go env -w GOPATH=$HOME/go

gedit ~/.bashrc
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
```

# пакеты
```
go get -u github.com/gin-gonic/gin
go get -u github.com/gin-contrib/sessions
go get -u gorm.io/gorm
go get -u gorm.io/driver/sqlite
go get -u go.uber.org/dig
go get -u google.golang.org/grpc
go get -u github.com/golang/protobuf/protoc-gen-go
go get -u github.com/julienschmidt/httprouter
```



# install
```
https://golang.org/doc/install
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
```

$HOME/.export
export PATH=$PATH:/usr/local/go/bin

# run bash command
```
go env -w GO111MODULE=auto
```




# old installation instruction
```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go

rm -rf /usr/local/go
tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz

go env -w GO111MODULE=auto
go env -w GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
```
