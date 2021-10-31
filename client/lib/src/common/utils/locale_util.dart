import 'dart:ui' show Locale;

import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class LocaleUtil {
  LocaleUtil._();
  static String localeToString(final Locale locale) => locale.languageCode;
  static Locale stringToLocale(final String languageCode) => Locale(languageCode);
}
