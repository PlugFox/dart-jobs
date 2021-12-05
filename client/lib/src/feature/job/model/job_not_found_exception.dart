import 'package:dart_jobs_client/src/common/model/exceptions.dart';

class JobNotFoundException extends NotFoundException {
  const JobNotFoundException(
    final StackTrace stackTrace, [
    final String? message,
  ]) : super(
          stackTrace,
          message,
        );

  @override
  String toString() {
    if (message == null) return 'JobNotFoundException';
    return 'JobNotFoundException: $message';
  }
}
