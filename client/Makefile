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
	@echo "Getting dependencies"
	@flutter pub get

upgrade: get
	@echo "Upgrading dependencies"
	@flutter pub upgrade

upgrade-major: get
	@echo "Upgrading dependencies --major-versions"
	@flutter pub upgrade --major-versions

outdated:
	@flutter pub outdated --transitive --show-all --dev-dependencies --dependency-overrides

codegen: get
	@echo "Running codegeneration"
	-dart run tools/set_version.dart
	@flutter pub run build_runner build --delete-conflicting-outputs --release
	@flutter pub global run intl_utils:generate

build: codegen build-site

build-site:
	@flutter build web --release --no-source-maps --pwa-strategy \
		offline-first --web-renderer auto --base-href / \
		--dart-define=environment=production

deploy:
	@firebase deploy

serve-firebase:
	@firebase serve --only hosting -p 80

serve-flutter: codegen
	@echo "Serve as web app"
	flutter run -d web-server --dart-define=environment=development