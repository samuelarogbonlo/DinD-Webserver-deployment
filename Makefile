.PHONY: all up down load-test monitor-and-scale

all: up

up:
	docker-compose up -d --build

down:
	docker-compose down

