up:
	@cd srcs && docker compose up -d

down:
	@cd srcs && docker compose down

restart: down up

fclean:
	@cd srcs && docker compose down --rmi all --volumes
	@docker network prune -f
	@rm -rf /home/$(USER)/data

re: fclean
	@cd srcs && docker compose up -d --remove-orphans --force-recreate

.PHONY: down up fclean re