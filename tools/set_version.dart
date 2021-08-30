import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

final io.File pubspecSource = io.File('pubspec.yaml');
final io.File pubspecNew = io.File('pubspec.yaml.tmp');
final io.File versionEnv = io.File('version.env');

void main() => runZonedGuarded<void>(
      () async {
        await prepare();
        final sink = pubspecNew.openWrite(
          mode: io.FileMode.write,
          encoding: utf8,
        );
        var notFound = true;
        try {
          await pubspecSource
              .openRead()
              .transform<String>(const Utf8Decoder())
              .transform<String>(const LineSplitter())
              .asyncMap<String>((line) async {
                if (notFound & line.startsWith('version:')) {
                  final buildName =
                      line.substring(8).split('+').first.trim(); // 1.2.3
                  final buildNumber =
                      DateTime.now().millisecondsSinceEpoch ~/ 1000; // 4
                  final version = '$buildName+$buildNumber'; // 1.2.3+4
                  io.stdout.writeln('Version: $version');
                  await versionEnv.writeAsString(
                    'VERSION=$version\r\nBUILD_NAME=$buildName\r\nBUILD_NUMBER=$buildNumber',
                  );
                  notFound = false;

                  return 'version: $version';
                }

                return line;
              })
              .map<String>((line) => '$line\r\n')
              .transform<List<int>>(const Utf8Encoder())
              .forEach(sink.add);
        } on Object {
          await sink.close();
          rethrow;
        }
        await sink.flush();
        await sink.close();
        await pubspecSource.delete();
        await pubspecNew.rename(pubspecSource.path);
        io.exit(0);
      },
      (error, stackTrace) {
        io.stdout.writeln('\x1B[31m$error\x1B[0m');
        io.exit(2);
      },
    );

Future<void> prepare() async {
  if (!pubspecSource.existsSync()) {
    throw UnsupportedError('Файл "pubspec.yaml" не найден.');
  }
  if (pubspecNew.existsSync()) {
    await pubspecNew.delete();
  }
  await pubspecNew.create();
  if (versionEnv.existsSync()) {
    await versionEnv.delete();
  }
  await versionEnv.create();
}

Future<void> run(String executable) {
  final commands = executable
      .split(' ')
      .where((element) => element.isNotEmpty)
      .toList(growable: false);

  return io.Process.start(
    commands.first,
    commands.sublist(1),
    runInShell: true,
  ).then<void>(
    (process) => Future.wait<void>(
      <Future<void>>[
        process.stdout.forEach(
          (message) {
            io.stdout.writeln(utf8.decode(message));
          },
        ),
        process.stderr.forEach(
          (message) {
            final error = utf8.decode(message);
            io.stdout.writeln('\x1B[31m$error\x1B[0m');
            throw UnsupportedError(error);
          },
        ),
      ],
    ),
  );
}
