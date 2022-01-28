import 'package:dart_jobs_client/src/feature/bug_report/model/bug_report_entity.dart';
import 'package:sentry/sentry.dart';

// ignore: one_member_abstracts
abstract class IBugReportRepository {
  Future<void> send(BugReportEntity report);
}

class BugReportRepository implements IBugReportRepository {
  @override
  Future<void> send(BugReportEntity report) async {
    final message = '${report.typeRepresentation}\n'
        '${report.hasUserId ? 'From: ${report.userRepresentation}\n' : ''}'
        '${report.message}';
    final id = await Sentry.captureMessage(
      message,
      level: SentryLevel.info,
      hint: 'User feedback',
    );
    await Sentry.captureUserFeedback(
      SentryUserFeedback(
        eventId: id,
        name: report.userId,
        email: report.email,
        comments: message,
      ),
    );
  }
}
