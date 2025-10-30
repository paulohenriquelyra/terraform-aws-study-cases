#!/bin/bash
# Habilita o modo de depuração para logar todos os comandos em /var/log/cloud-init-output.log
set -x

# Habilita e instala o Apache 2.4 usando amazon-linux-extras para garantir uma versão estável
amazon-linux-extras enable httpd
yum clean metadata
yum install -y httpd

# Garante que o diretório do site exista
mkdir -p /var/www/html

# Cria o arquivo index.html
cat > /var/www/html/index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF
# Inicia o serviço do Apache e o habilita para iniciar no boot
systemctl start httpd
systemctl enable httpd
