import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/settings/data/settings_repository.dart';
import 'package:dart_jobs/src/feature/settings/model/user_settings.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

part 'settings_bloc.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const SettingsEvent._();

  const factory SettingsEvent.getFromCache() = _GetFromCacheSettingsEvent;

  const factory SettingsEvent.getFromServer(
    final AuthenticatedUser user,
  ) = _GetFromServerSettingsEvent;

  const factory SettingsEvent.update(
    final AuthenticatedUser user,
    final UserSettings settings,
  ) = _UpdateSettingsEvent;
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState(final UserSettings settings) = _SettingsState;
}

class SettingsBLoC extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository _repository;
  SettingsBLoC({
    required final ISettingsRepository repository,
  })  : _repository = repository,
        super(SettingsState(repository.getFromCache()));

  @override
  Stream<SettingsState> mapEventToState(final SettingsEvent event) => event.when<Stream<SettingsState>>(
        getFromCache: _getFromCache,
        getFromServer: _getFromServer,
        update: _update,
      );

  Stream<SettingsState> _getFromCache() async* {
    l.i('Получим настройки из кэша');
    final settings = _repository.getFromCache();
    yield SettingsState(settings);
    l.i('Настройки из кэша получены');
  }

  Stream<SettingsState> _getFromServer(final AuthenticatedUser user) async* {
    if (user.isNotAuthenticated) return;
    l.i('Получим настройки с сервера для пользователя #${user.uid}');
    final settings = await _repository.getFromServer(user);
    yield SettingsState(settings);
    l.i('Настройки с сервера получены');
  }

  Stream<SettingsState> _update(final AuthenticatedUser user, final UserSettings settings) async* {
    if (user.isNotAuthenticated) return;
    l.i('Сохраним настройки для пользователя #${user.uid}');
    await _repository.update(user, settings);
    yield SettingsState(settings);
    l.i('Настройки сохранены');
  }
}
