#brower

```
cd ~/
sudo wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz
sudo xz -d node-v8.4.0-linux-x64.tar.xz
sudo tar xvf node-v8.4.0-linux-x64.tar
sudo mv node-v8.4.0-linux-x64 /usr/local/node
sudo ln -s /usr/local/node/bin/node /usr/local/bin/node
sudo ln -s /usr/local/node/bin/npm /usr/local/bin/npm
node -v
npm -v
sudo npm install -g bower
bower --version
```