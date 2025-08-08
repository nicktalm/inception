up:
	@cd srcs && docker compose up -d
	@ls /home/$(USER)/data || mkdir /home/$(USER)/data
	@ls /home/$(USER)/data/mariadb || mkdir /home/$(USER)/data/mariadb
	@ls /home/$(USER)/data/wordpress || mkdir /home/$(USER)/data/wordpress
down:
	@cd srcs && docker compose down

restart: down up

fclean:
	@cd srcs && docker compose down --rmi all --volumes
	@docker network prune -f
	@ls /home/$(USER)/data && rm -rf /home/$(USER)/data

re: fclean
	@cd srcs && docker compose up -d --remove-orphans --force-recreate

.PHONY: down up fclean re