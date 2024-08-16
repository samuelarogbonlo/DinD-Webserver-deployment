# Docker-In-Docker Deployment 

![Implementation Architecture](https://github.com/user-attachments/assets/0e337001-c6ce-4480-b216-ba529263bbfc)

This repository contains the infrastructure setup for a web server, including Nginx, Prometheus, Alertmanager, a Flask application, and JMeter for load testing. It also has a major feature of docker-in-docker service for autoscaling and a couple of other interesting stuff. 

## Prerequisites
- Docker
- Docker Compose
- Git

## Steps
Following the steps below, the infrastructure should bootstrap on its own
```
git clone https://github.com/samuelarogbonlo/p2p-webserver-deployment.git
make up
docker-compose ps
```

> **_Note_**
> - Navigate to the `alertmanager.yml` file and fill in the slack app API URL and channel name. You can check more details on getting the URL [here](https://www.svix.com/resources/guides/how-to-get-slack-webhook-url/)

> - Lastly, you can run `docker service ls` to list all the services, ports and statuses before curling or testing on the browser.

## Clean Up
- To remove the entire stack, run
```
docker-compose down
```
- To clean up all docker resources, run
```
docker network prune
docker volume prune
```

# Maintainers

[@samuelarogbonlo](https://github.com/samuelarogbonlo)

# Collaborators
- [YOUR NAME HERE] - Feel free to contribute to the codebase by resolving any open issues, refactoring, adding new features, writing test cases, or doing anything else to make the project better and helpful to the community. Please feel free to send pull requests.

# License

Fully open source and dual-licensed under MIT and Apache 2.
