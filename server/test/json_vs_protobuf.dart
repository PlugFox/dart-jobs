import 'dart:convert';

import 'package:dart_jobs_shared/model.dart';
import 'package:test/test.dart';

void main() {
  final date = DateTime.now();
  final chunk = JobsChunk(
    endOfList: false,
    jobs: Iterable<Job>.generate(
      100,
      (i) => Job(
        id: (date.millisecondsSinceEpoch ~/ 1000 - i * 60 * 60).toRadixString(36),
        //weight: request.before.toDateTime().millisecondsSinceEpoch ~/ 1000,
        updated: date.subtract(Duration(hours: i)),
        created: date.subtract(Duration(hours: i)),
        creatorId: 'creatorId',
        data: JobData(
          title: 'title ${date.subtract(Duration(hours: i)).millisecondsSinceEpoch.toRadixString(36)}',
          company: 'company ${date.subtract(Duration(hours: i)).millisecondsSinceEpoch.toRadixString(36)}',
          country: 'company ${date.subtract(Duration(hours: i)).millisecondsSinceEpoch.toRadixString(36)}',
          remote: false,
        ),
      ),
    ).toList(growable: false),
  );
  var json = 0;
  var proto = 0;
  proto = chunk.toBytes().length;
  json = JsonUtf8Encoder().convert(chunk.toJson()).length;
  test('proto < json', () {
    // ignore: avoid_print
    print(
      'json: $json bytes\n'
      'protobuf: $proto bytes\n'
      'json / protobuf = ${json / proto}',
    );
    expect(proto < json, isTrue);
    final x = JobsChunk.fromBytes(chunk.toBytes());
    expect(x.endOfList, chunk.endOfList);
    expect(x.length, chunk.length);
  });
}
