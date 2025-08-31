DOCKER_COMPOSE = srcs/docker-compose.yml

up:
	docker compose -f $(DOCKER_COMPOSE) up --build -d

down:
	docker compose -f $(DOCKER_COMPOSE) down

clean:
	docker compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans

fclean: clean
	docker image prune -af 

re: fclean up