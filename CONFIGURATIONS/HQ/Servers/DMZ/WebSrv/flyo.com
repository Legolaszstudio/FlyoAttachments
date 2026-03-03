# /etc/nginx/sites-available/flyo.com
server {
        listen 80;
        listen [::]:80;

        root /var/www/flyo.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name flyo.com www.flyo.com;

        location / {
                try_files $uri $uri/ =404;
        }
}
