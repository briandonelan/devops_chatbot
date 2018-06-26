# devops_chatbot

Amazon Lex + Lambda chatbot to control Jenkins builds

### /infra directory
- aws.inventory file contains ansible inventory
- chatbot.service file is copied to remote EC2 instance to spawn docker-compose as a systemd daemon
- devops.briandonelan.com is an nginx site config file
- docker-compose.yml is a docker-compose file specifying Jenkins, Mattermost, and Nginx reverse proxy containers
- mime.types is an nginx support file
- nginx.conf is an nginx site file
- playbook.yml is the ansible playbook for deploying the above to the target EC2 node

### source materials
- mattermost integrations: https://developers.mattermost.com/integrate/examples/
- aws Lex samples: https://github.com/aws-samples?utf8=%E2%9C%93&q=lex&type=&language=
- do we want to consider integrating with Alexa / AWS Polly?