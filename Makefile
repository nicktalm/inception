NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
DOCKER_COMPOSE = cd srcs && docker compose -p $(NAME) -f docker-compose.yml

GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
RESET = \033[0m

all: up

up:
	@printf "$(GREEN)Starting $(NAME) containers...$(RESET)\n"
	@ls /home/$(USER)/data/mariadb || mkdir -p /home/$(USER)/data/mariadb
	@ls /home/$(USER)/data/wordpress ||mkdir -p /home/$(USER)/data/wordpress
	@$(DOCKER_COMPOSE) up -d
	@printf "$(GREEN)Containers are running!$(RESET)\n"

build:
	@printf "$(YELLOW)Building $(NAME) containers...$(RESET)\n"
	@$(DOCKER_COMPOSE) build
	@printf "$(GREEN)Build complete!$(RESET)\n"

down:
	@printf "$(YELLOW)Stopping $(NAME) containers...$(RESET)\n"
	@$(DOCKER_COMPOSE) down
	@printf "$(GREEN)Containers stopped!$(RESET)\n"

rebuild:
	@printf "$(RED)Fully cleaning $(NAME) project (containers, images, volumes)...$(RESET)\n"
	@$(DOCKER_COMPOSE) down --volumes --remove-orphans
	@docker system prune -a --volumes --force
	@rm -rf /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
	@printf "$(YELLOW)Rebuilding $(NAME) containers...$(RESET)\n"
	@$(DOCKER_COMPOSE) build --no-cache
	@$(DOCKER_COMPOSE) up -d
	@printf "$(GREEN)Rebuild complete!$(RESET)\n"


clean: down
	@printf "$(RED)Removing all containers and images...$(RESET)\n"
	@docker system prune -a --volumes --force
	@printf "$(GREEN)Clean complete!$(RESET)\n"

logs:
	@printf "$(YELLOW)Showing container logs...$(RESET)\n"
	@$(DOCKER_COMPOSE) logs

restart:
	@printf "$(YELLOW)Restarting containers...$(RESET)\n"
	@$(DOCKER_COMPOSE) restart
	@printf "$(GREEN)Containers restarted!$(RESET)\n"

.PHONY: all up build rebuild down clean logs restart