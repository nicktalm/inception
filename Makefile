up:
	@ls ~/data || mkdir ~/data
	@ls ~/data/mariadb || mkdir ~/data/mariadb
	@ls ~/data/wordpress || mkdir ~/data/wordpress
	@cd srcs && docker compose up -d
down:
	@cd srcs && docker compose down

restart: down up

fclean:
	@cd srcs && docker compose down --rmi all --volumes
	@docker network prune -f
	@ls ~/data && rm -rf ~/data

re: fclean
	@cd srcs && docker compose up -d --remove-orphans --force-recreate

.PHONY: down up fclean re