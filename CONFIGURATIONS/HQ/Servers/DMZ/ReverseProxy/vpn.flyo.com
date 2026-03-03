upstream flyo_headscale_upstream {
    zone flyo_vpn 1024K;
    server 10.0.254.20:8080 max_fails=3 fail_timeout=10s;
    server 10.0.255.20:8080 max_fails=3 fail_timeout=10s;
    keepalive 1;
}

server {
        listen 443 ssl;
        listen [::]:443 ssl;
        access_log /var/log/nginx/access.log;

        include snippets/self-signed.conf;
        include snippets/ssl-params.conf;

        server_name vpn.flyo.com;

        location / {
                proxy_set_header        Host $host;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;
                proxy_redirect          http:// https://;
                proxy_http_version      1.1;
                proxy_set_header        Upgrade $http_upgrade;
                proxy_set_header        Connection "upgrade";
                proxy_pass              http://flyo_headscale_upstream/;
                proxy_read_timeout      86400s;
                proxy_buffering         off;
                proxy_connect_timeout   5s;
                client_max_body_size    0;

                add_header Access-Control-Allow-Origin "https://hsadmin.flyo.com" always;
                add_header Access-Control-Allow-Methods "GET, POST, OPTIONS" always;
                add_header Access-Control-Allow-Headers "Content-Type, Authorization" always;
                add_header Access-Control-Allow-Credentials "true" always;
                if ($request_method = 'OPTIONS') {
                        add_header Access-Control-Allow-Origin "https://hsadmin.flyo.com";
                        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS";
                        add_header Access-Control-Allow-Headers "Content-Type, Authorization";
                        add_header Access-Control-Allow-Credentials "true";
                        return 204;
                }
        }
}

server {
        listen 80;
        listen [::]:80;

        server_name vpn.flyo.com;

        location / {
                proxy_set_header        Host $host;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;
                proxy_http_version      1.1;
                proxy_set_header        Upgrade $http_upgrade;
                proxy_set_header        Connection "upgrade";
                proxy_pass              http://flyo_headscale_upstream/;
                proxy_read_timeout      86400s;
                proxy_buffering         off;
                proxy_connect_timeout   5s;
                client_max_body_size    0;

                add_header Access-Control-Allow-Origin "https://hsadmin.flyo.com" always;
                add_header Access-Control-Allow-Methods "GET, POST, OPTIONS" always;
                add_header Access-Control-Allow-Headers "Content-Type, Authorization" always;
                add_header Access-Control-Allow-Credentials "true" always;
                if ($request_method = 'OPTIONS') {
                        add_header Access-Control-Allow-Origin "https://hsadmin.flyo.com";
                        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS";
                        add_header Access-Control-Allow-Headers "Content-Type, Authorization";
                        add_header Access-Control-Allow-Credentials "true";
                        return 204;
                }
        }
}
