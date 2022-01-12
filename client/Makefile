.PHONY: clean format get upgrade outdated

clean:
	@echo "Cleaning the project"
	@flutter clean

format:
	@echo "Formatting the code"
	@dart fix --apply .
	@dart format -l 120 --fix .

get:
	@echo "Geting dependencies"
	@flutter pub get

upgrade: get
	@echo "Upgrading dependencies"
	@flutter pub upgrade

upgrade-major: get
	@echo "Upgrading dependencies --major-versions"
	@flutter pub upgrade --major-versions

outdated:
	@flutter pub outdated

codegen: get
	@echo "Running codegeneration"
	@flutter pub run build_runner build --delete-conflicting-outputs --release
	@flutter pub global activate intl_utils
	@flutter pub global run intl_utils:generate

build-site:
	@docker run --rm -it -v ${PWD}:/project --workdir /project --user=root:root --name flutter_stable_web \
		plugfox/flutter:stable-web /bin/bash -c \
		"cd /project/client && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs --release && flutter build web --release --no-source-maps --pwa-strategy offline-first --web-renderer auto --base-href /"

