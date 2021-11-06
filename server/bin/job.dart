import 'package:dart_jobs_server/src/common/util/runner.dart';
import 'package:dart_jobs_server/src/feature/job/service/job_service.dart';
import 'package:grpc/grpc.dart';
import 'package:l/l.dart';

void main(List<String> args) => l.capture(
      () => runner<Server>(
        initialization: () async {
          final server = Server(
            <Service>[
              JobService(),
            ],
            <Interceptor>[
              (call, method) {
                l.i('Вызван метод ${method.name}');
              }
            ],
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
