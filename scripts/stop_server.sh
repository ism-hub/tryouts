#!/bin/bash
echo Stop-server called, stopping nginx and our webapp..
sudo systemctl stop nginx
sudo systemctl stop webapp
