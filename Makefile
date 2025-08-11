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
	@ls ~/data && sudo rm -rf ~/data
	@sudo docker network prune -f

re: fclean
	@cd srcs && docker compose up -d --remove-orphans --force-recreate

.PHONY: down up fclean re