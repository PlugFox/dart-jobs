.PHONY: clean format get upgrade

clean:
	@echo "Cleaning the project"
	@rm -rf pubspec.lock
	@flutter --no-color clean

format:
	@echo "Formatting the code"
	@dart --no-color format -l 120 --fix .

get:
	@echo "Geting dependencies"
	@flutter --no-color pub get

upgrade: get
	@echo "Upgrading dependencies"
	@flutter --no-color pub upgrade

codegen: get
	@echo "Running codegeneration"
	@flutter --no-color pub run build_runner build --delete-conflicting-outputs --release
	@flutter --no-color pub global run intl_utils:generate

outdated:
	@flutter --no-color pub outdated