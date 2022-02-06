//@dart=2.16

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:pub_semver/pub_semver.dart' as semver;

final io.File pubspecSource = io.File('pubspec.yaml');
final io.File pubspecNew = io.File('pubspec.yaml.tmp');
final io.File versionEnv = io.File('version.env');

// ignore: long-method
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
              .asyncMap<String>((final line) async {
                if (notFound & line.startsWith('version:')) {
                  // https://ihateregex.io/expr/semver/
                  final source = semver.Version.parse(line.substring(8).trim());
                  final buildName = '${source.major}.${source.minor}.${source.patch}';
                  final buildNumber = DateTime.now().millisecondsSinceEpoch ~/ 1000;
                  final preRelease = source.preRelease.join('-');
                  final version = '$buildName${preRelease.isEmpty ? '' : '-$preRelease'}+$buildNumber'; // 1.2.3+4-alfa
                  io.stdout.writeln('Version: $version');
                  await versionEnv.writeAsString(
                    'VERSION=$version\r\n'
                    'VERSION_MAJOR=${source.major}\r\n'
                    'VERSION_MINOR=${source.minor}\r\n'
                    'VERSION_PATCH=${source.patch}\r\n'
                    'VERSION_BUILD_NAME=$buildName\r\n'
                    'VERSION_PRE_RELEASE=$preRelease\r\n'
                    'VERSION_BUILD_NUMBER=$buildNumber\r\n',
                  );
                  notFound = false;

                  return 'version: $version';
                }

                return line;
              })
              .map<String>((final line) => '$line\r\n')
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
      (final error, final stackTrace) {
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

Future<void> run(final String executable) {
  final commands = executable.split(' ').where((final element) => element.isNotEmpty).toList(growable: false);

  return io.Process.start(
    commands.first,
    commands.sublist(1),
    runInShell: true,
  ).then<void>(
    (final process) => Future.wait<void>(
      <Future<void>>[
        process.stdout.forEach(
          (final message) {
            io.stdout.writeln(utf8.decode(message));
          },
        ),
        process.stderr.forEach(
          (final message) {
            final error = utf8.decode(message);
            io.stdout.writeln('\x1B[31m$error\x1B[0m');
            throw UnsupportedError(error);
          },
        ),
      ],
    ),
  );
}
