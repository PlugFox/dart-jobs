import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class LocaleUtil {
  LocaleUtil._();
  static final Map<String, DateFormat> _dateFormat = <String, DateFormat>{};
  static String dateToString(BuildContext context, DateTime dateTime) {
    final languageCode = context.localization.language_code;
    final dt = dateTime.toLocal();
    final now = DateTime.now();
    if (dt.day == now.day) {
      return (_dateFormat['${languageCode}_hms'] ??= DateFormat.Hms()).format(dt);
    }
    return (_dateFormat['${languageCode}_yMMMMd'] ??= DateFormat.yMMMMd()).format(dt);
  }

  static String localeToString(final Locale locale) => locale.languageCode;
  static Locale stringToLocale(final String languageCode) => Locale(languageCode);
}
