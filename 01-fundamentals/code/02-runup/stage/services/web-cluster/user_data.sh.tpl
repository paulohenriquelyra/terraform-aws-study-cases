#!/bin/bash
# Script de inicialização para configurar um servidor web Apache.

# Redireciona toda a saída (stdout e stderr) para o log do sistema para facilitar a depuração.
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Para o script se um comando falhar, facilitando a depuração.
set -e

# Instala o servidor web Apache (httpd) e o curl.
echo "Instalando Apache (httpd) e curl..."
yum install -y httpd curl

# Habilita o serviço httpd para iniciar no boot.
systemctl enable httpd

# Inicia o serviço httpd imediatamente.
systemctl start httpd

# Obtém o endereço IP privado da instância
echo "Obtendo metadados da instância..."
INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Cria a página de teste no diretório padrão do Apache.
echo "Criando a página index.html..."
cat > /var/www/html/index.html <<EOF
<h1>Hello, World!</h1>
<p>Esta página está sendo servida pela instância EC2 com o IP: <strong>$INSTANCE_IP</strong></p>
<p>Endereço do Banco de Dados (RDS): <strong>${db_address}</strong></p>
<p>Porta do Banco de Dados (RDS): <strong>${db_port}</strong></p>
EOF