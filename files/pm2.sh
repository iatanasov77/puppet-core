#!/bin/bash

env PATH=$PATH:/home/vagrant/.nvm/versions/node/v18.16.0/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant
