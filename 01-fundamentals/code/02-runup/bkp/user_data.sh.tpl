#!/bin/bash
# Update and install Apache
yum update -y
yum install -y httpd
echo "<h1>${web_page_text}</h1>" > /var/www/html/index.html
sed -i "s/Listen 80/Listen ${web_port}/" /etc/httpd/conf/httpd.conf
systemctl start httpd
systemctl enable httpd

# Create user and enable password authentication
useradd ${ssh_user}
echo "${ssh_password}" | passwd ${ssh_user} --stdin
usermod -aG wheel ${ssh_user}
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd