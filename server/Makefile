.PHONY: clean format get upgrade

clean:
	@echo "Cleaning the project"
	dart clean

format:
	@echo "Formatting the code"
	@dart fix --apply
	dart format -l 120 --fix

get:
	@echo "Geting dependencies"
	dart pub get

upgrade: get
	@echo "Upgrading dependencies"
	dart pub upgrade

codegen: get
	@echo "Running codegeneration"
	@dart run build_runner build --delete-conflicting-outputs --release
	@dart format -l 120 --fix lib/src/common/database lib/src/feature/job/database
