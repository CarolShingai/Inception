USER = cshingai

MARIA_DB_DIR = /home/$(USER)/data/mariadb
WORDPRESS_DB_DIR = /home/$(USER)/data/wordpress

COMPOSE_FILE = srcs/docker-compose.yml
DOCKER_COMPOSE_EXEC = docker-compose -f $(COMPOSE_FILE)

all: config up

config:
	mkdir -p $(MARIA_DB_DIR)
	mkdir -p $(WORDPRESS_DB_DIR)
	@if [ ! -f srcs/.env ]; then \
		cp srcs/.env.example srcs/.env; \
		sed -i '' 's/your_login/$(USER)/g' srcs/.env; \
		echo ".env criado com LOGIN=$(USER)"; \
	else \
		echo ".env já existe"; \
	fi
build:
	$(DOCKER_COMPOSE_EXEC) build

up: build
	$(DOCKER_COMPOSE_EXEC) up -d

down:
	$(DOCKER_COMPOSE_EXEC) down

ps:
	$(DOCKER_COMPOSE_EXEC) ps

ls:
	docker volume ls

clean:
	$(DOCKER_COMPOSE_EXEC) down --rmi all -v
	
fclean: clean	
	rm -f ./srcs/.env
	docker system prune -a --volumes -f
	sudo rm -rf /home/$(USER)

re: fclean all

hard: update all

update:
	sudo apt-get update && sudo apt-get upgrade -y

.PHONY: all up config build down ps ls clean fclean re hard