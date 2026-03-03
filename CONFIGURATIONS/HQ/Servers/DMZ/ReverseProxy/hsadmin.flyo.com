upstream flyo_hsadmin_upstream {
    zone flyo_hsadmin 1024K;
    server 10.0.254.10:81 max_fails=3 fail_timeout=10s;
    server 10.0.255.10:81 max_fails=3 fail_timeout=10s;
    keepalive 1;
}

server {
        listen 443 ssl;
        listen [::]:443 ssl;
	access_log /var/log/nginx/access.log;

	include snippets/self-signed.conf;
	include snippets/ssl-params.conf;

	server_name hsadmin.flyo.com;

	location / {
		proxy_set_header	Host $host;
		proxy_set_header	X-Real-IP $remote_addr;
		proxy_set_header	X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header	X-Forwarded-Proto $scheme;
		proxy_redirect		http:// https://;
		proxy_http_version      1.1;
		proxy_set_header        Upgrade $http_upgrade;
		proxy_set_header        Connection "upgrade";
		proxy_pass              http://flyo_hsadmin_upstream/;
		proxy_read_timeout      86400s;
		proxy_buffering         off;
                proxy_connect_timeout   5s;
		client_max_body_size    0;
	}
}

server {
	listen 80;
	listen [::]:80;

	server_name hsadmin.flyo.com;

	return 301 https://$server_name$request_uri;
}
