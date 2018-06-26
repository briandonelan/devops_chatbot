server {
    listen [::]:80;
    listen 80;

    server_name mattermost.devops.briandonelan.com *.mattermost.devops.briandonelan.com devops.briandonelan.com *.devops.briandonelan.com "";

    add_header Cache-Control "no-cache, must-revalidate, max-age=0";

    location / {
        proxy_pass http://172.31.14.48:8065;
        proxy_pass_request_headers on;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
        proxy_redirect $scheme://$host:8065 $scheme://$host:80;
    }
}

server {
    listen [::]:80;
    listen 80;
    server_name jenkins.devops.briandonelan.com *.jenkins.devops.briandonelan.com;
    add_header Cache-Control "no-cache, must-revalidate, max-age=0";
    location / {
        proxy_pass http://172.31.14.48:8080;
        proxy_pass_request_headers on;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
        proxy_redirect $scheme://$host:8080 $scheme://$host:80;
    }
}

server {
    listen [::]:80;
    listen 80;
    server_name jenkinsapi.devops.briandonelan.com *.jenkinsapi.devops.briandonelan.com;
    add_header Cache-Control "no-cache, must-revalidate, max-age=0";
    location / {
        proxy_pass http://172.31.14.48:50000;
        proxy_pass_request_headers on;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
        proxy_redirect $scheme://$host:50000 $scheme://$host:80;
    }
}
