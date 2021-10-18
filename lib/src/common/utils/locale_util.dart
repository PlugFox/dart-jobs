import 'dart:ui' show Locale;

/// Namespace
abstract class LocaleUtil {
  LocaleUtil._();
  static String localeToString(Locale locale) => locale.languageCode;
  static Locale stringToLocale(String languageCode) => Locale(languageCode);
}
