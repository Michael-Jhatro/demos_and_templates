.PHONY: all clean start

PROJECT_NAME := my_project# Project name variable
USER := $(shell whoami)

CONTAINER_NAME := $(PROJECT_NAME)_$(USER)



start:
	@echo "Starting containers using docker-compose with container name: $(CONTAINER_NAME)"
	CONTAINER_NAME=$(CONTAINER_NAME) docker compose -f docker/docker-compose.yml up -d

rebuild:
	@echo "Rebuilding containers..."
	CONTAINER_NAME=$(CONTAINER_NAME) PROJECT_NAME=$(PROJECT_NAME) docker compose -f docker/docker-compose.yml down
	CONTAINER_NAME=$(CONTAINER_NAME) PROJECT_NAME=$(PROJECT_NAME) docker compose -f docker/docker-compose.yml build
	CONTAINER_NAME=$(CONTAINER_NAME) PROJECT_NAME=$(PROJECT_NAME) docker compose -f docker/docker-compose.yml up -d


bash: start
	docker exec -it $(CONTAINER_NAME) bash

all:
	@echo "Building project: $(PROJECT_NAME)"

clean:
	@echo "Cleaning project: $(PROJECT_NAME)"
