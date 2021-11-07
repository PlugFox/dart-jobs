.PHONY: clean format get upgrade outdated push docker-run-stage docker-push-stage docker-run-prod docker-push-prod

clean:
	@echo "Cleaning the project"
	dart clean

format:
	@echo "Formatting the code"
	@dart fix --apply .
	dart format -l 120 --fix .

get:
	@echo "Geting dependencies"
	dart pub get

upgrade: get
	@echo "Upgrading dependencies"
	dart pub upgrade

codegen: get
	@echo "Running codegeneration"
	dart run build_runner build --delete-conflicting-outputs --release
	dart global run intl_utils:generate

docker-build-stage:
	@echo "Build staging docker images"
	docker build --no-cache --force-rm --compress \
			--file ./docker/service.dockerfile \
			--tag registry.plugfox.dev/dart-jobs-service:stage .

docker-push-stage:
	@echo "Push staging docker images"
	docker push registry.plugfox.dev/dart-jobs-service:stage

docker-run-stage:
	@echo "Run staging docker images"
	docker run -d -p 8081:80 --name dart-jobs-service-stage registry.plugfox.dev/dart-jobs-service:stage

deploy-stage: docker-build-stage docker-push-stage
	@echo "Deploy staging into docker swarm"
	docker --log-level debug --host "ssh://pfx@api.plugfox.dev" stack deploy --compose-file ./docker/dart-jobs.stage.stack.yml --orchestrator swarm --prune --with-registry-auth dart-jobs-stage

docker-build-prod:
	@echo "Build release docker images"
	docker build --no-cache --force-rm --compress \
			--file ./docker/job.dockerfile \
			--tag registry.plugfox.dev/dart-jobs-service:prod .

docker-push-prod:
	@echo "Push release docker images"
	docker push registry.plugfox.dev/dart-jobs-service:prod

docker-run-prod:
	@echo "Run release docker images"
	docker run -d -p 8081:80 --name dart-jobs-service-prod registry.plugfox.dev/dart-jobs-service:prod

deploy-prod: docker-build-prod docker-push-prod
	@echo "Deploy release into docker swarm"
	docker --log-level debug --host "ssh://pfx@api.plugfox.dev" stack deploy --compose-file ./docker/dart-jobs.prod.stack.yml --orchestrator swarm --prune --with-registry-auth dart-jobs-prod