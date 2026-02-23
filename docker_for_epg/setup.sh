#!/bin/sh

sudo mkdir    /opt/mirakurun
sudo mkdir -p /opt/mirakurun/run
sudo mkdir -p /opt/mirakurun/opt
sudo mkdir -p /opt/mirakurun/config
sudo mkdir -p /opt/mirakurun/data
sudo chown -R root /opt/mirakurun/config


sudo mkdir    /opt/epgstation
sudo mkdir -p /opt/epgstation/config
sudo mkdir -p /opt/epgstation/data
sudo mkdir -p /opt/epgstation/thumbnail
sudo mkdir -p /opt/epgstation/logs
sudo chown -R root /opt/epgstation

sudo mkdir -p /opt/recorded
sudo chown -R root /opt/recorded

# copy EPG files
sudo cp ./epgstation/config/enc.js.template                 /opt/epgstation/config/enc.js
sudo cp ./epgstation/config/config.yml.template             /opt/epgstation/config/config.yml
sudo cp ./epgstation/config/operatorLogConfig.sample.yml    /opt/epgstation/config/operatorLogConfig.yml
sudo cp ./epgstation/config/epgUpdaterLogConfig.sample.yml  /opt/epgstation/config/epgUpdaterLogConfig.yml
sudo cp ./epgstation/config/serviceLogConfig.sample.yml     /opt/epgstation/config/serviceLogConfig.yml


