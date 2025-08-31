#!bin/bash
set -e

if [ ! -e /etc/.firstrun ]; then
# generate ssl cetificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048  \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/CN=${DOMAIN_NAME}" \
        >/dev/null 2>/dev/null

# copy nginx config
cat << EOF > /etc/nginx/http.d/default.conf
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name ${DOMAIN_NAME};

    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;

    ssl_protocols TLSv1.2 TLSv1.3;

    root /var/www/html;
    index index.php index.htm index.html;

    location / {
        try_files \$uri \$uri/ /index.php\$args;
    }

    location ~ \.php {
        try_files \$fastcgi_script_name =404;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params; 
    }
}
EOF
    touch /etc/.firstrun
fi

exec nginx -g 'daemon off;'