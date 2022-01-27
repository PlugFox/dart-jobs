import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class LocaleUtil {
  LocaleUtil._();

  /// Красивое представление даты в зависимости от текущей локали
  static String dateToString(BuildContext context, DateTime dateTime) {
    final languageCode = context.localization.language_code;
    final dt = dateTime.toLocal();
    final now = DateTime.now();
    if (dt.day == now.day) {
      // (_dateFormat['${languageCode}_hms'] ??= DateFormat.Hms()).format(dt)
      return TimeOfDay.fromDateTime(dt).format(context);
    }
    return (_dateFormat['${languageCode}_yMMMMd'] ??= DateFormat.yMMMMd()).format(dt);
  }

  static final Map<String, DateFormat> _dateFormat = <String, DateFormat>{};

  /// Форматирование даты в зависимости от текущей локали и паттерна
  static String formatDate(final BuildContext context, final DateTime date, final String pattern) =>
      AppLocalization.dateFormat(pattern, AppLocalization.localeOf(context)).format(date.toLocal());

  /// Получить локализованные строки в зависимости от текущего языка
  Localized localizationOf(BuildContext context) => AppLocalization.localize(context);

  /// Текущая локаль
  Locale localeOf(BuildContext context) => AppLocalization.localeOf(context);

  /// Поддерживаемые локали
  static List<Locale> get supportedLocales => AppLocalization.supportedLocales;

  /// Языковой код локали
  static String localeToString(final Locale locale) => locale.languageCode;

  /// Локаль из языкового кода
  static Locale stringToLocale(final String languageCode) => Locale(languageCode);
}
