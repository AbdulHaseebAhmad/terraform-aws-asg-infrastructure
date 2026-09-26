#!/bin/bash
apt update -y
apt install -y nginx
echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
systemctl restart nginx
systemctl enable nginx