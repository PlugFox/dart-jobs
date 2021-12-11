import 'package:bloc/bloc.dart';
import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs_client/src/feature/settings/data/settings_repository.dart';
import 'package:dart_jobs_client/src/feature/settings/model/user_settings.dart';
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
        super(SettingsState(repository.getFromCache())) {
    on<SettingsEvent>(
      (event, emit) => event.map<void>(
        getFromCache: (event) => _getFromCache(event, emit),
        getFromServer: (event) => _getFromServer(event, emit),
        update: (event) => _update(event, emit),
      ),
    );
  }

  Future<void> _getFromCache(_GetFromCacheSettingsEvent event, Emitter<SettingsState> emit) async {
    l.i('Получим настройки из кэша');
    final settings = _repository.getFromCache();
    emit(SettingsState(settings));
    l.i('Настройки из кэша получены');
  }

  Future<void> _getFromServer(_GetFromServerSettingsEvent event, Emitter<SettingsState> emit) async {
    if (event.user.isNotAuthenticated) return;
    l.i('Получим настройки с сервера для пользователя #${event.user.uid}');
    final settings = await _repository.getFromServer(event.user);
    emit(SettingsState(settings));
    l.i('Настройки с сервера получены');
  }

  Future<void> _update(_UpdateSettingsEvent event, Emitter<SettingsState> emit) async {
    if (event.user.isNotAuthenticated) return;
    l.i('Сохраним настройки для пользователя #${event.user.uid}');
    await _repository.update(event.user, event.settings);
    emit(SettingsState(event.settings));
    l.i('Настройки сохранены');
  }
}
