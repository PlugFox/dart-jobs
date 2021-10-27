import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

/// Namespace
@sealed
abstract class MoneyUtil {
  MoneyUtil._();

  /// Представить доллары как целое число
  static int usdToInt(final Money? money) => money is Money ? money.minorUnits.toInt() : 0;

  /// Получить доллары из целого числа
  static Money usdFromInt(final num? money) => money is num ? Money.fromWithCurrency(money / 100, usd) : zeroMoney;

  /// 0 Долларов
  static final Money zeroMoney = Money.fromBigIntWitCurrency(BigInt.zero, usd);

  /// Получить валюту USD
  static final Currency usd = CommonCurrencies().usd;
}
