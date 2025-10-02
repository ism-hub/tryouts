#!/bin/bash
echo Stop-server called, stopping nginx and our webapp 2..

systemctl --quiet is-active webapp && sudo systemctl stop webapp 2>&1 || true
systemctl --quiet is-active nginx && sudo systemctl stop nginx 2>&1 || true
