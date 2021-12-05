import 'package:dart_jobs_client/src/common/bloc/io/app_observer_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/src/common/bloc/web/app_observer_web.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:meta/meta.dart';

@sealed
abstract class BlocObserver {
  static IBlocObserver get instance => _singleton ??= createBlocObserver();
  static IBlocObserver? _singleton;
  BlocObserver._();
}
