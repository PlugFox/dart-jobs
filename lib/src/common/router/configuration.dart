import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../feature/authentication/widget/profile_page.dart';
import '../../feature/feed/widget/feed_page.dart';
import '../../feature/job/widget/job_page.dart';
import '../../feature/not_found/widget/not_found_page.dart';
import '../../feature/settings/widget/settings_page.dart';

/// Конфигурация страниц приложения
abstract class PageConfiguration {
  const PageConfiguration([this.state]);

  /// Состояние
  final Map<String, Object?>? state;

  /// Предидущая конфигурация
  /// Если null - значит это корневая конфигурация
  PageConfiguration? get previous;

  /// Это корневая конфигурация
  bool get isRoot => previous == null;

  /// Преобразовать конфигурацию в uri
  Uri toUri();

  /// Построить страницы исходя из контекста и текущей конфигурации
  @mustCallSuper
  Iterable<Page<Object?>> buildPages(BuildContext context) =>
      previous?.buildPages(context) ?? const Iterable<Page<Object?>>.empty();
}

/// Класс для корневой конфигурации, страниц из которых нельзя вернуться на предидущую
abstract class RootPageConfiguration implements PageConfiguration {
  const RootPageConfiguration();

  @override
  @nonVirtual
  bool get isRoot => true;

  @override
  @nonVirtual
  PageConfiguration? get previous => null;

  @override
  Map<String, Object?>? get state => const <String, Object?>{};

  @override
  Uri toUri() => Uri.parse('/');

  @override
  Iterable<Page<Object?>> buildPages(BuildContext context) => const <Page<Object?>>[
        FeedPage(),
      ];
}

/// Конфигурация страницы с не найденным контентом
class NotFoundPageConfiguration extends PageConfiguration {
  const NotFoundPageConfiguration([PageConfiguration? previousConfiguration]) : previous = previousConfiguration;

  @override
  final PageConfiguration? previous;

  @override
  Uri toUri() => Uri.parse('/not_found');

  @override
  Iterable<Page<Object?>> buildPages(BuildContext context) sync* {
    yield* super.buildPages(context);
    yield const NotFoundPage();
  }
}

class FeedPageConfiguration extends RootPageConfiguration {
  const FeedPageConfiguration();
}

class ProfilePageConfiguration extends PageConfiguration {
  const ProfilePageConfiguration();

  @override
  PageConfiguration? get previous => const FeedPageConfiguration();

  @override
  Uri toUri() => Uri.parse('/profile');

  @override
  Iterable<Page<Object?>> buildPages(BuildContext context) sync* {
    yield* super.buildPages(context);
    yield const ProfilePage();
  }
}

class SettingsPageConfiguration extends PageConfiguration {
  const SettingsPageConfiguration();

  @override
  PageConfiguration? get previous => const FeedPageConfiguration();

  @override
  Uri toUri() => Uri.parse('/settings');

  @override
  Iterable<Page<Object?>> buildPages(BuildContext context) sync* {
    yield* super.buildPages(context);
    yield const SettingsPage();
  }
}

class JobPageConfiguration extends PageConfiguration {
  /// Идентификатор работы
  final String id;

  JobPageConfiguration({
    required final this.id,
  }) : super(
          <String, Object?>{
            'job': <String, Object?>{
              'id': id,
            },
          },
        );

  @override
  PageConfiguration? get previous => const FeedPageConfiguration();

  @override
  Uri toUri() => Uri.parse('/job/id$id');

  @override
  Iterable<Page<Object?>> buildPages(BuildContext context) sync* {
    yield* super.buildPages(context);
    yield JobPage(id: id);
  }
}
