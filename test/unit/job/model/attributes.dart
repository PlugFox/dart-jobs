// ignore_for_file: long-method

import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money2/money2.dart';

void main() {
  group(
    'Аттрибуты работы',
    () {
      test(
        'Зарплатная вилка - сериализация и десериализация',
        () {
          final sourceSalary = SalaryJobAttribute(
            from: Money.fromIntWithCurrency(100000, CommonCurrencies().usd),
            to: Money.fromIntWithCurrency(200000, CommonCurrencies().usd),
          );
          final json = sourceSalary.toJson();
          final salary = SalaryJobAttribute.fromJson(json);
          expect(salary.from, sourceSalary.from);
          expect(salary.to, sourceSalary.to);
        },
      );
      test(
        'Зарплатная вилка - проверка соответсвия',
        () {
          final a = SalaryJobAttribute(
            from: Money.fromIntWithCurrency(0, CommonCurrencies().usd),
            to: Money.fromIntWithCurrency(0, CommonCurrencies().usd),
          );
          final b = SalaryJobAttribute.unknown;
          expect(a.from, b.from);
          expect(a.to, b.to);
          expect(a, b);
        },
      );
      test(
        'Уровень разработчика - сериализация и десериализация',
        () {
          const sourceLevel = DeveloperLevelJobAttribute(
            from: DeveloperLevel.junior,
            to: DeveloperLevel.senior,
          );
          final json = sourceLevel.toJson();
          final level = DeveloperLevelJobAttribute.fromJson(json);
          expect(level.from, sourceLevel.from);
          expect(level.to, sourceLevel.to);
          expect(level, sourceLevel);
        },
      );
      test(
        'Уровень разработчика - проверка соответсвия',
        () {
          // ignore: use_named_constants
          const a = DeveloperLevelJobAttribute(
            from: DeveloperLevel.unknown,
            to: DeveloperLevel.unknown,
          );
          const b = DeveloperLevelJobAttribute.unknown;
          expect(a.from, b.from);
          expect(a.to, b.to);
          expect(a, b);
        },
      );
    },
  );
}
