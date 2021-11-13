import 'package:dart_jobs_server/src/common/util/init_database.dart';
import 'package:dart_jobs_server/src/feature/job/database/job_dao.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() => group(
      'job_dao',
      () {
        JobDao? jobDao;
        final fakeCreatorId = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
        final fakeJobData = JobData(
          title: 'title ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
          company: 'company ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
          country: 'company ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
          remote: false,
        );
        setUpAll(
          () async {
            jobDao = JobDao(
              await initDatabase(),
            );
          },
        );
        test(
          'create',
          () async {
            final creatorId = fakeCreatorId;
            final jobData = fakeJobData;
            final result = await jobDao!.createJob(
              creatorId: creatorId,
              data: jobData,
            );
            expect(result.creatorId, creatorId);
            expect(result.data.title, jobData.title);
          },
        );
      },
    );
