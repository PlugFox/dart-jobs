import 'package:dart_jobs_server/src/common/util/runner.dart';
import 'package:grpc/grpc.dart';
import 'package:l/l.dart';

class GreeterService extends GreeterServiceBase {
  GreeterService();

  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) {
    l.i('${request.name} # ${call.headers}, ${call.clientMetadata}, ${call.trailers}');
    return Future<HelloReply>.value(HelloReply()..message = 'Hello, ${request.name}!');
  }
}

void main(List<String> args) => l.capture(
      () => runner<Server>(
        initialization: () async {
          final server = Server(
            <Service>[
              GreeterService(),
            ],
            const <Interceptor>[],
            CodecRegistry(
              codecs: const <Codec>[
                GzipCodec(),
                IdentityCodec(),
              ],
            ),
          );
          await server.serve(
            port: 9090,
          );
          l.i('Server listening on ${server.port}...');
          return server;
        },
        onShutdown: (server) async {
          await server.shutdown();
        },
      ),
      const LogOptions(
        handlePrint: true,
        outputInRelease: true,
      ),
    );
