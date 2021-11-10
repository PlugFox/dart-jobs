import 'package:dart_jobs/src/common/localization/localizations.dart';
import 'package:dart_jobs/src/feature/authentication/widget/profile_page.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_page.dart';
import 'package:dart_jobs/src/feature/job/widget/job_create_page.dart';
import 'package:dart_jobs/src/feature/job/widget/job_page.dart';
import 'package:dart_jobs/src/feature/not_found/widget/not_found_page.dart';
import 'package:dart_jobs/src/feature/settings/widget/settings_page.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Конфигурация страниц приложения
abstract class PageConfiguration {
  const PageConfiguration([this.state]);

  /// Состояние
  final Map<String, Object?>? state;

  /// Заголовок
  String get pageTitle;

  /// Предидущая конфигурация
  /// Если null - значит это корневая конфигурация
  PageConfiguration? get previous;

  /// Это корневая конфигурация
  bool get isRoot => previous == null;

  /// Преобразовать конфигурацию в uri
  Uri toUri();

  /// Построить страницы исходя из контекста и текущей конфигурации
  @mustCallSuper
  Iterable<Page<Object?>> buildPages(final BuildContext context) =>
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
  String get pageTitle => Localized.current.title;

  @override
  Uri toUri() => Uri.parse('/');

  @override
  Iterable<Page<Object?>> buildPages(final BuildContext context) => const <Page<Object?>>[
        FeedPage(),
      ];
}

/// Конфигурация страницы с не найденным контентом
class NotFoundPageConfiguration extends PageConfiguration {
  const NotFoundPageConfiguration([final PageConfiguration? previousConfiguration]) : previous = previousConfiguration;

  @override
  final PageConfiguration? previous;

  @override
  Uri toUri() => Uri.parse('/not_found');

  @override
  String get pageTitle => '${Localized.current.title} / 404';

  @override
  Iterable<Page<Object?>> buildPages(final BuildContext context) sync* {
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
  String get pageTitle => '${Localized.current.title} / ${Localized.current.profile}';

  @override
  Iterable<Page<Object?>> buildPages(final BuildContext context) sync* {
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
  String get pageTitle => '${Localized.current.title} / ${Localized.current.settings}';

  @override
  Iterable<Page<Object?>> buildPages(final BuildContext context) sync* {
    yield* super.buildPages(context);
    yield const SettingsPage();
  }
}

class JobPageConfiguration extends PageConfiguration {
  JobPageConfiguration({
    required final this.job,
    final this.edit = false,
  }) : super(
          <String, Object?>{
            'job': <String, Object?>{
              ...job.toJson(),
              'edit': job.hasID && edit,
            },
          },
        );

  /// Работа
  final Job job;

  /// Открыть в режиме редактирования, а не просмотра
  final bool edit;

  @override
  String get pageTitle => '${Localized.current.title} / ${job.data.title.isEmpty ? job.id : job.data.title}';

  @override
  PageConfiguration? get previous => const FeedPageConfiguration();

  @override
  Uri toUri() => Uri.parse('/job/${job.id}');

  @override
  Iterable<Page<Object?>> buildPages(final BuildContext context) sync* {
    yield* super.buildPages(context);
    yield JobPage(
      job: job,
      edit: edit,
    );
  }
}

class JobCreatePageConfiguration extends PageConfiguration {
  JobCreatePageConfiguration()
      : super(
          <String, Object?>{
            'job': <String, Object?>{
              'edit': true,
            },
          },
        );

  @override
  String get pageTitle => '${Localized.current.title} / New Job';

  @override
  PageConfiguration? get previous => const FeedPageConfiguration();

  @override
  Uri toUri() => Uri.parse('/job/');

  @override
  Iterable<Page<Object?>> buildPages(final BuildContext context) sync* {
    yield* super.buildPages(context);
    yield JobCreatePage();
  }
}
