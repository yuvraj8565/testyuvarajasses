#!/bin/bash

sudo amazon-linux-extras install nginx1 -y;
sudo systemctl start nginx;
sudo systemctl enable nginx;
sudo wget https://yuvraj-assessment.s3.ap-southeast-1.amazonaws.com/index.html -O /usr/share/nginx/html/index.html;
sudo systemctl restart nginx;
