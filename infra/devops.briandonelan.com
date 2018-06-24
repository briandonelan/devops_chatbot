upstream mattermost {
   server localhost:8065;
}

upstream jenkins {
   server localhost:8080;
}

upstream jenkinsapi {
   server localhost:50000;
}

server {
    listen 80;
    server_name mattermost.devops.briandonelan.com;

    location / {
        proxy_pass http://mattermost;
        proxy_pass_request_headers on;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        # proxy_redirect $scheme://$host:8065 $scheme://$host:80;
    }
}

server {
    listen 80;
    server_name jenkins.devops.briandonelan.com;

    location / {
        proxy_pass http://jenkins;
        proxy_pass_request_headers on;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name jenkinsapi.devops.briandonelan.com;

    location / {
        proxy_pass http://jenkinsapi;
        proxy_pass_request_headers on;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
   listen 80;

   # listen on the base host
   server_name devops.briandonelan.com;

   # and redirect to the app host (declared below)
   return 301 http://www.mattermost.devops.briandonelan.com$request_uri;
}