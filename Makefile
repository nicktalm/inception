COMPOSE := docker-compose.yml

all: up

up: srcs/$(COMPOSE)
	@cd srcs && docker compose -p inception -f $(COMPOSE) up -d

down: srcs/$(COMPOSE)
	@cd srcs && docker compose -p inception down
