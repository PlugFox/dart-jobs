.PHONY: clean format get upgrade upgrade-major outdated

clean:
	@echo "Cleaning the project"
	@dart clean

format:
	@echo "Formatting the code"
	@dart fix --apply .
	@dart format -l 120 --fix .

get:
	@echo "Geting dependencies"
	@dart pub get

upgrade: get
	@echo "Upgrading dependencies"
	@dart pub upgrade

upgrade-major: get
	@echo "Upgrading dependencies --major-versions"
	@dart pub upgrade --major-versions

outdated:
	@dart pub outdated

codegen: get
	@echo "Running codegeneration"
	@dart run build_runner build --delete-conflicting-outputs --release
	@dart format -l 120 --fix lib/src/generated lib/src/model