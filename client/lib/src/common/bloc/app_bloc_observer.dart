import 'package:dart_jobs_client/src/common/bloc/platform/app_observer_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/src/common/bloc/platform/app_observer_web.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

@sealed
abstract class AppBlocObserver {
  static BlocObserver get instance => _singleton ??= createBlocObserver();
  static BlocObserver? _singleton;
  AppBlocObserver._();
}
