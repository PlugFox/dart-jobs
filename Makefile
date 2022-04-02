.PHONY: clean format get upgrade outdated push run deploy

all:
	@echo "Мейкфайл управляющий монорепо. Можно собрать и перераскатить весь сервер."

clean:
	@echo "Cleaning the project"
	dart clean --directory=server

format:
	@echo "Formatting the code"
	@dart fix --apply server
	dart format -l 120 --fix server

get:
	@echo "Geting dependencies"
	dart pub get --directory=server

upgrade: get
	@echo "Upgrading dependencies"
	dart pub upgrade --directory=server

build-server:
	@echo "Build release docker images"
	@docker-compose -f ./docker-compose.yml build --no-cache --force-rm --compress --parallel

push-server:
	@echo "Push release docker images"
	@docker-compose -f ./docker-compose.yml push

start-server:
	@echo "Run local server"
	@docker-compose -f ./docker-compose.yml up --detach

stop-server:
	@echo "Stop local server"
	@docker-compose -f ./docker-compose.yml down

build-and-push-server: build-server push-server
