#brower

```
cd ~/
sudo wget https://nodejs.org/dist/v9.2.0/node-v9.2.0-linux-x64.tar.xz
sudo xz -d node-v9.2.0-linux-x64.tar.xz
sudo tar xvf node-v9.2.0-linux-x64.tar
sudo mv node-v9.2.0-linux-x64 /usr/local/node
sudo ln -s /usr/local/node/bin/node /usr/local/bin/node
sudo ln -s /usr/local/node/bin/npm /usr/local/bin/npm
node -v
npm -v
sudo npm install -g bower
sudo ln -s /usr/local/node/bin/bower /usr/local/bin/bower
bower --version
```