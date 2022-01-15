.PHONY: clean format get upgrade upgrade-major outdated codegen init build build-site

init:
	@npm install -g firebase-tools
	@firebase init
	-firebase login
	@flutter pub global activate intl_utils
	@dart pub global activate flutterfire_cli
	@flutterfire configure \
		-i dev.plugfox.dartjobs \
		-m dev.plugfox.dartjobs \
		-a dev.plugfox.dartjobs \
		-p dart-job \
		-e plugfox@gmail.com \
		-o lib/src/common/constant/firebase_options.g.dart

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

build: codegen build-site

build-site:
	@flutter build web --release --no-source-maps --pwa-strategy offline-first --web-renderer auto --base-href /

deploy:
	@firebase deploy

serve:
	@firebase serve --only hosting -p 80