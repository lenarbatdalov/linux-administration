# Go install
```
download -->> https://golang.org/dl/
sudo tar -xzf go1.14.4.linux-amd64.tar.gz -C /usr/local/

sudo nano ~/.profile
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
source ~/.profile

mkdir $HOME/go

user - lenarbatdalov
mkdir -p go/src/github.com/lenarbatdalov/hello

nano ~/go/src/github.com/lenarbatdalov/hello/hello.go

package main
import "fmt"
func main() {
    fmt.Printf("hello, world\n")
}

go install ~/go/src/github.com/lenarbatdalov/hello

hello

which hello     /home/lenar/go/bin/hello
```