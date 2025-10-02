#!/bin/bash
echo starting my webapp using nginx and Actix..

# sudo systemctl enable webapp
sudo systemctl start webapp

# Start nginx now
sudo systemctl start nginx

# Check status
systemctl status nginx

curl http://localhost


