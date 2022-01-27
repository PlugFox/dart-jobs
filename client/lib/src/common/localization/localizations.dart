library localizations;

import 'package:dart_jobs_client/src/common/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'package:dart_jobs_client/src/common/localization/l10n.dart';

/// Шоткаты для контекста для управления локализацией
extension AppLocalizationsX on BuildContext {
  Localized get localization => AppLocalization.localize(this);
  Locale get locale => AppLocalization.localeOf(this);
  MaterialLocalizations get materialLocalizations => MaterialLocalizations.of(this);
  List<Locale> get supportedLocales => AppLocalization.supportedLocales;
  String formatDate(final DateTime date, final String pattern) =>
      AppLocalization.dateFormat(pattern, AppLocalization.localeOf(this)).format(date.toLocal());
}

/// Абстрактный класс для управления локализацией
abstract class AppLocalization {
  const AppLocalization._();

  static final Map<String, Map<Locale, DateFormat>> _dateFormatters = <String, Map<Locale, DateFormat>>{};
  static DateFormat dateFormat(final String pattern, [Locale locale = fallbackLocale]) {
    final patternMap = _dateFormatters[pattern];
    if (patternMap == null) {
      final result = DateFormat(pattern);
      _dateFormatters[pattern] = <Locale, DateFormat>{
        locale: result,
      };
      return result;
    }
    return patternMap[locale] ??= DateFormat(pattern);
  }

  static const Locale fallbackLocale = Locale('en');

  static const LocalizationsDelegate<Localized> delegate = AppLocalizationDelegate();

  /// Получить и подписаться на локализированную строку для текущей локали
  static Localized localize(final BuildContext context) => Localized.of(context);

  /// The locale of the Localizations widget for the widget tree that
  /// corresponds to [BuildContext] `context`.
  ///
  /// If no [Localizations] widget is in scope then the [Localizations.localeOf]
  /// method will throw an exception.
  static Locale localeOf(final BuildContext context) => Localizations.localeOf(context);

  /// The locale of the Localizations widget for the widget tree that
  /// corresponds to [BuildContext] `context`.
  ///
  /// If no [Localizations] widget is in scope then this function will return
  /// null.
  static Locale? maybeLocaleOf(final BuildContext context) => Localizations.maybeLocaleOf(context);

  /// Returns the localized resources object of the given `type` for the widget
  /// tree that corresponds to the given `context`.
  ///
  /// Returns null if no resources object of the given `type` exists within
  /// the given `context`.
  ///
  /// This method is typically used by a static factory method on the `type`
  /// class. For example Flutter's MaterialLocalizations class looks up Material
  /// resources with a method defined like this:
  ///
  /// ```dart
  /// static MaterialLocalizations of(BuildContext context) {
  ///    return Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
  /// }
  /// ```
  static T? of<T>(final BuildContext context, final Type type) => Localizations.of(context, type);

  /// Поддердживаемые локали
  static List<Locale> get supportedLocales => (delegate as AppLocalizationDelegate).supportedLocales;

  /// Whether resources for the given locale can be loaded by this delegate.
  ///
  /// Return true if the instance of `T` loaded by this delegate's [load]
  /// method supports the given `locale`'s language.
  static bool isSupported(final Locale locale) => delegate.isSupported(locale);

  /// Start loading the resources for `locale`. The returned future completes
  /// when the resources have finished loading.
  ///
  /// It's assumed that the this method will return an object that contains
  /// a collection of related resources (typically defined with one method per
  /// resource). The object will be retrieved with [Localizations.of].
  static Future<Localized> load(final Locale locale) => delegate.load(locale);

  /// Returns true if the resources for this delegate should be loaded
  /// again by calling the [load] method.
  ///
  /// This method is called whenever its [Localizations] widget is
  /// rebuilt. If it returns true then dependent widgets will be rebuilt
  /// after [load] has completed.
  static bool shouldReload(final AppLocalizationDelegate old) => delegate.shouldReload(old);
}
