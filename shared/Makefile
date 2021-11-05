.PHONY: clean format get upgrade outdated

clean:
	@echo "Cleaning the project"
	@dart clean

format:
	@echo "Formatting the code"
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

codegen: get
	@echo "Running codegeneration"
	@flutter pub global activate protoc_plugin
	protoc -Iproto proto/google/protobuf/**.proto --dart_out="grpc:lib/src/generated"
	protoc -Iproto proto/**.proto --dart_out="grpc:lib/src/generated"
	@dart format -l 120 --fix lib/src/generated
	@dart run build_runner build --delete-conflicting-outputs --release

outdated:
	@dart pub outdated