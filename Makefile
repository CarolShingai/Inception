USER = cshingai

MARIA_DB_DIR = home/$(USER)/data/mariadb
WORDPRESS_DB_DIR = home/$(USER)/data/wordpress

COMPOSE_FILE = srcs/docker-compose.yml
DOCKER_COMPOSE_EXEC = docker-compose -f $(COMPOSE_FILE)

all: config up

config:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Creating .env file"; \
		echo "LOGIN=$(LOGIN)" > $(ENV_FILE); \
		echo "DOMAIN=$(LOGIN).42.fr" >> $(ENV_FILE); \
		echo "" >> $(ENV_FILE); \
		echo "ADMIN_NAME=$(LOGIN)" >> $(ENV_FILE); \
		echo "ADMIN_PASSWORD=$(LOGIN)1234" >> $(ENV_FILE); \
		echo "ADMIN_EMAIL=$(LOGIN)@email.com" >> $(ENV_FILE); \
		echo "" >> $(ENV_FILE); \
		echo "USER_NAME=user" >> $(ENV_FILE); \
		echo "USER_PASSWORD=user" >> $(ENV_FILE); \
		echo "USER_EMAIL=user@email.com" >> $(ENV_FILE); \
		echo "" >> $(ENV_FILE); \
		echo "TITLE=HOME PAGE" >> $(ENV_FILE); \
		echo "" >> $(ENV_FILE); \
		echo "DB_NAME=wordpress_db" >> $(ENV_FILE); \
	else \
		echo ".env already exists"; \
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
	docker compose down --rmi all -v
	
fclean: clean	
	rm ./srcs/.env
	docker system prune -a -v -f
	sudo rm -rf home/$(USER)

re: fclean all

hard: update all

update:
	sudo apt-get update && sudo apt-get upgrade -y

.PHONY: all up config build down ps ls clean fclean re hard