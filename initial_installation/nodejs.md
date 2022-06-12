# [nodejs, npm, npx, yarn](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions)
```zsh
curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs

npm config set prefix ~/.npm
export PATH="$PATH:$HOME/.npm/bin"
source ~/.profile

npm install -g yarn
npm install -g @vue/cli
```
