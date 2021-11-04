import 'package:dart_jobs_shared/grpc.dart';
import 'package:grpc/grpc.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';

void main(List<String> args) => l.capture(
      () async {
        final channel = ClientChannel(
          'localhost',
          port: 9090,
          options: ChannelOptions(
            credentials: const ChannelCredentials.insecure(),
            idleTimeout: const Duration(minutes: 2),
            connectionTimeout: const Duration(minutes: 25),
            userAgent: 'dart-grpc/${platform.isWeb ? 'web' : 'io'}/${platform.operatingSystem.when(
              android: () => 'android',
              fuchsia: () => 'fuchsia',
              iOS: () => 'iOS',
              linux: () => 'linux',
              macOS: () => 'macOS',
              windows: () => 'windows',
              unknown: () => 'unknown',
            )}',
            codecRegistry: CodecRegistry(
              codecs: const <Codec>[
                GzipCodec(),
                IdentityCodec(),
              ],
            ),
          ),
        );
        final stub = GreeterClient(channel);

        final name = args.isNotEmpty ? args[0] : 'world';
        await Future<void>.delayed(const Duration(seconds: 1));

        try {
          for (var i = 0; i < 5; i++) {
            await Future<void>.delayed(const Duration(seconds: 1));
            final sw = Stopwatch()..start();
            final response = await stub.sayHello(
              HelloRequest()..name = '$name #$i',
              options: CallOptions(compression: const GzipCodec()),
            );
            sw.stop();
            l.i('Greeter #$i client received: ${response.message} with ${sw.elapsedMilliseconds} ms');
          }
        } on Object catch (e) {
          l.e('Caught error: $e');
        }
        await channel.shutdown();
      },
      const LogOptions(
        handlePrint: true,
        outputInRelease: true,
      ),
    );
