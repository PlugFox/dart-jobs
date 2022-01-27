import 'package:collection/collection.dart';
import 'package:dart_jobs_client/src/common/router/pages.dart';
import 'package:dart_jobs_client/src/common/router/router_util.dart';
import 'package:flutter/widgets.dart';

/// Конфигурация состояния приложения и всех его маршрутов
@immutable
abstract class IRouteConfiguration implements RouteInformation {
  /// Это корневая конфигурация
  bool get isRoot;

  /// Предидущая конфигурация
  /// Если null - значит это корневая конфигурация
  IRouteConfiguration? get previous;

  /// Представление текущего стека навигации в виде строки
  /// См также [RouteInformation.location]
  @override
  String get location;

  /// Состояние конфигурации
  /// Где ключ хэштаблицы - [AppPage.location] страницы
  /// А значение - хэштаблица состояния страницы
  /// См также [RouteInformation.state]
  @override
  Map<String, Object?>? get state;

  /// Добавить страницу, роут приложения к конфигурации
  /// выпустив новую конфигурацию на основании текущей
  IRouteConfiguration add(AppPage page);
}

/// Базовая конфигурация
abstract class RouteConfigurationBase implements IRouteConfiguration {
  const RouteConfigurationBase();

  @override
  bool get isRoot => previous != null;

  @override
  IRouteConfiguration? get previous {
    IRouteConfiguration? getPrevious() {
      if (location == '/' || location == 'feed' || location == 'home' || location.isEmpty) return null;
      try {
        final uri = Uri.parse(location);
        final pathSegments = uri.pathSegments;
        if (pathSegments.length == 1) {
          return const HomeRouteConfiguration();
        }
        final newLocation = pathSegments.sublist(0, pathSegments.length - 1).join('/');
        final newState = state;
        if (newState != null) {
          newState.remove(pathSegments.last);
        }
        return DynamicRouteConfiguration(
          newLocation,
          newState,
        );
      } on Object {
        return null;
      }
    }

    return getPrevious();
  }

  @override
  IRouteConfiguration add(AppPage page) {
    if (page.location.isEmpty) return this;
    final arguments = page.arguments;
    final newLocation = RouteInformationUtil.normalize('$location/${page.location}');
    if (arguments is Map<String, Object?> || state != null) {
      return DynamicRouteConfiguration(
        newLocation,
        <String, Object?>{
          ...?state,
          if (arguments is Object) page.location: arguments,
        },
      );
    }
    return DynamicRouteConfiguration(newLocation);
  }

  @override
  String toString() => 'RouteConfiguration($location)';

  @override
  int get hashCode => Object.hash(location, state);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IRouteConfiguration &&
          location == other.location &&
          const DeepCollectionEquality.unordered().equals(
            state,
            other.state,
          ));
}

/// Класс для корневой конфигурации, страниц из которых нельзя вернуться на предидущую
mixin RootPageConfiguration on RouteConfigurationBase {
  @override
  bool get isRoot => true;

  @override
  IRouteConfiguration? get previous => null;
}

/// Презет конфигурации домашнего, корневого роута
class HomeRouteConfiguration extends RouteConfigurationBase with RootPageConfiguration {
  const HomeRouteConfiguration();

  @override
  String get location => 'feed';

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}

/// Конфигурация описывающая отсутсвующий контент
class JobRouteConfiguration extends RouteConfigurationBase {
  const JobRouteConfiguration(int id) : location = 'feed/job-$id';
  const JobRouteConfiguration.create() : location = 'feed/job';

  @override
  bool get isRoot => false;

  @override
  IRouteConfiguration? get previous => const HomeRouteConfiguration();

  @override
  final String location;

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}

/// Конфигурация описывающая отсутсвующий контент
class NotFoundRouteConfiguration extends RouteConfigurationBase {
  const NotFoundRouteConfiguration();

  @override
  bool get isRoot => false;

  @override
  IRouteConfiguration? get previous => const HomeRouteConfiguration();

  @override
  String get location => 'feed/404';

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}

/// Конфигурация настроек
class SettingsRouteConfiguration extends RouteConfigurationBase {
  const SettingsRouteConfiguration();

  @override
  bool get isRoot => false;

  @override
  IRouteConfiguration? get previous => const HomeRouteConfiguration();

  @override
  String get location => 'feed/settings';

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}

/// Профиль пользователя
class ProfileRouteConfiguration extends RouteConfigurationBase {
  const ProfileRouteConfiguration();

  @override
  bool get isRoot => false;

  @override
  IRouteConfiguration? get previous => const HomeRouteConfiguration();

  @override
  String get location => 'feed/profile';

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}

/// Динамическая конфигурация, получаемая путем преобразования заданных презетов
/// или при изменении конфигурации на платформе
class DynamicRouteConfiguration extends RouteConfigurationBase {
  const DynamicRouteConfiguration(this.location, [this.state]);

  @override
  final String location;

  @override
  final Map<String, Object?>? state;
}
