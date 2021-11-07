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
              /// CORS
              (call, method) {
                //call.headers?.addAll(
                //  <String, String>{
                //    'Access-Control-Allow-Methods': 'GET, PUT, DELETE, POST, OPTIONS',
                //    'Access-Control-Allow-Origin': '*',
                //    'Access-Control-Expose-Headers': '*',
                //    'Access-Control-Allow-Headers': 'user-agent,x-grpc-web,x-user-agent',
                //    'Access-Control-Max-Age': '60',
                //  },
                //);
                l.i('Вызван метод ${method.name}');
              },
            ],
            //CodecRegistry(
            //  codecs: const <Codec>[
            //    GzipCodec(),
            //    IdentityCodec(),
            //  ],
            //),
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
