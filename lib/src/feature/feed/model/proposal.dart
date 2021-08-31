import 'package:meta/meta.dart';

@immutable
abstract class Proposal {
  String get type;
  String get id;
  DateTime get created;
  DateTime get updated;
}
