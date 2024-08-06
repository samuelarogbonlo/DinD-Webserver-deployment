# P2P-Webserver-Deployment

![Implementation Architecture](https://github.com/user-attachments/assets/0e337001-c6ce-4480-b216-ba529263bbfc)

This repository contains the infrastructure setup for a web server that includes Nginx, Prometheus, Alertmanager, a Flask application, and JMeter for load testing.

## Prerequisities
- Docker
- Docker Compose
- Git

## Steps
Following the steps below, the infratstructure should bootstrap on its own
```
git clone https://github.com/samuelarogbonlo/p2p-webserver-deployment.git
make up
docker-compose ps
```

> **_Note_**
> - Navigate to to `alertmanager.yml` file and fill the slack app API URL and channel name. You can check more details on getting URL [here](https://www.svix.com/resources/guides/how-to-get-slack-webhook-url/)


## Testing and Monitoring
Run each of the URLs below on a browser
- __Webserver:__ Access the golang application at http://localhost:8080.
- __Prometheus:__ Access Prometheus at http://localhost:9090.
- __Alertmanager:__ Access Alertmanager at http://localhost:9093.
- __Flask Application:__ Access Flask app metrics at http://localhost:8080/metrics.

- Lastly, you can run `docker service ls` to list all the services and their statuses before testing in the browser.

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

# License

Fully open source and dual-licensed under MIT and Apache 2.
