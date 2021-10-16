.PHONY: clean format get upgrade outdated

clean:
	@echo "Cleaning the project"
	@rm -rf pubspec.lock
	@flutter clean

format:
	@echo "Formatting the code"
	@dart format -l 120 --fix .

get:
	@echo "Geting dependencies"
	@flutter pub get

upgrade: get
	@echo "Upgrading dependencies"
	@flutter pub upgrade

codegen: get
	@echo "Running codegeneration"
	@flutter pub run build_runner build --delete-conflicting-outputs --release
	@flutter pub global run intl_utils:generate

outdated:
	@flutter --no-color pub outdated