#!/bin/bash
sudo apt update -y
sudo apt install -y nginx stress-ng

sudo echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
sudo systemctl restart nginx
sudo systemctl enable nginx