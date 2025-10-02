#!/bin/bash
echo Installing dependecies..
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx curl

echo Configuring systemd-service for webapp..
sudo tee /etc/systemd/system/webapp.service > /dev/null <<'EOF'
[Unit]
Description=Rust Actix WebApp
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/usr/share/webapps/
ExecStart=/usr/share/webapps/webapp
Restart=on-failure
RestartSec=2s
Environment=RUST_LOG=info

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload

echo Configuring nginx..
sudo tee /etc/nginx/conf.d/mywebapp.conf > /dev/null <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass         http://127.0.0.1:8080;
        proxy_http_version 1.1;

        proxy_set_header   Host $host;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
EOF

sudo nginx -t
# Enable at boot
# sudo systemctl enable nginx
