import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:dart_jobs_server/src/common/util/args_util.dart';
import 'package:dart_jobs_server/src/common/util/init_database.dart';
import 'package:dart_jobs_server/src/feature/job/database/job_dao.dart';
import 'package:dart_jobs_server/src/feature/job/model/find_jobs_filter.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:test/test.dart';

void main([List<String>? args]) => group(
      'job_dao',
      () {
        Database? db;
        JobDao? jobDao;
        final fakeCreatorId = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
        final fakeJobData = JobData(
          title: 'title ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
          company: 'company ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
          country: 0,
          remote: false,
        );

        setUpAll(
          () async {
            jobDao = JobDao(
              db = await initDatabase(ArgsUtil.parse(args)),
            );
          },
        );

        test(
          'create, get, update and delete',
          () async {
            final creatorId = fakeCreatorId;
            final jobData = fakeJobData;

            await db!.transaction(
              (connection) async {
                final created = await jobDao!.createJob(
                  creatorId: creatorId,
                  data: jobData,
                  context: connection,
                );

                final fetched = await jobDao!.getJob(
                  id: created.id,
                  context: connection,
                );

                expect(fetched.creatorId, creatorId);
                expect(fetched.data.title, jobData.title);

                final updated = await jobDao!.updateJob(
                  id: fetched.id,
                  creatorId: fetched.creatorId,
                  data: fetched.data.copyWith(
                    title: 'updated',
                  ),
                  context: connection,
                );

                await jobDao!.setDeletionMark(
                  id: updated.id,
                  creatorId: updated.creatorId,
                  context: connection,
                );

                final deletedId = await jobDao!.delete(
                  id: updated.id,
                  creatorId: updated.creatorId,
                  context: connection,
                );

                expect(deletedId, created.id);
              },
            );
          },
        );

        test(
          'findJobs before',
          () async {
            await jobDao!.findJobs(
              filter: FindJobsFilter(
                after: null,
                before: DateTime.now(),
                limit: 100,
              ),
            );
          },
        );
      },
    );
