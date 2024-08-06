FROM docker:24

RUN apk add --no-cache bash

COPY ./scripts /scripts

COPY ./docker-compose.yml ./scripts/

WORKDIR /scripts

CMD ["bash", "monitor-and-scale.sh"]
