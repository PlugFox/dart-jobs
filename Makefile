.PHONY: clean format get upgrade outdated push run deploy

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

build:
	@echo "Build release docker images"
	#docker-compose -f ./dart-jobs.prod.compose.yml build --no-cache --force-rm --compress --parallel

push:
	@echo "Push release docker images"
	#docker-compose -f ./dart-jobs.prod.compose.yml push

run:
	@echo "Run release docker images"
	#docker run -d -p 9090:9090 --name dart-jobs-service-prod registry.plugfox.dev/dart-jobs-service:prod

deploy:
	@echo "Deploy release into docker swarm"
	docker --log-level debug --host "ssh://pfx@api.plugfox.dev" stack deploy --compose-file ./dart-jobs.prod.stack.yml --orchestrator swarm --prune --with-registry-auth dart-jobs-prod

build_and_deploy: build push deploy