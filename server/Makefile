.PHONY: clean format get upgrade outdated push

clean:
	@echo "Cleaning the project"
	dart clean

format:
	@echo "Formatting the code"
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

docker-build:
	@echo "Build docker images"
	docker build --no-cache --force-rm --compress \
			--file ./dockerfiles/echo.dockerfile \
			--tag registry.plugfox.dev/dart-jobs-echo:latest .
docker-push:
	@echo "Push docker images"
	docker push registry.plugfox.dev/dart-jobs-echo:latest

docker-run:
	@echo "Run docker images"
	docker run -d -p 8081:80 --name dart-jobs-echo registry.plugfox.dev/dart-jobs-echo:latest