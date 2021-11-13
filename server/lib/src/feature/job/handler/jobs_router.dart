import 'package:dart_jobs_server/src/common/handler/healthcheck.dart';
import 'package:dart_jobs_server/src/common/handler/not_found.dart';
import 'package:dart_jobs_server/src/feature/job/handler/create_job.dart';
import 'package:dart_jobs_server/src/feature/job/handler/delete_job.dart';
import 'package:dart_jobs_server/src/feature/job/handler/find_jobs.dart';
import 'package:dart_jobs_server/src/feature/job/handler/get_job.dart';
import 'package:dart_jobs_server/src/feature/job/handler/update_job.dart';
import 'package:shelf_router/shelf_router.dart';

/// Роутер для работ
final Router jobsRouter = Router()

  /// Паджинация или отбор последних из коллекции
  /// параметры отбора, количества и указателя передаются как query
  /// 200 (OK) - возвращает чанк данных [JobsChunk]
  ..get('/jobs', findJobs)

  /// Создание нового элемента в коллекции
  /// 201 (Created), заголовок 'Content-Location' ссылается на /jobs/id{id}, где ID - идентификатор нового экземпляра.
  ..post('/jobs', createJob)

  /// Получение элемента по идентификатору
  /// 200 (OK) - получаем данные работы по идентификатору
  ..get('/jobs/id<id>', getJob)

  /// Обновление данных по идентификатору
  /// в теле содержатся новые данные [JobData]
  /// 200 - в случае успеха и [Job] в теле
  ..put('/jobs/id<id>', updateJob)

  /// Удалить работу по идентификатору
  /// 204 (No Content) - в случае успеха
  ..delete('/jobs/id<id>', deleteJob)

  /// Health check
  ..get('/health', healthCheck)

  /// 404 (Not Found)
  ..all('/<ignored|.*>', notFound);
