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
          final now = DateTime.now();
          final sourceSalary = Job(
            id: 'id',
            creatorId: 'creatorId',
            title: 'title',
            company: 'company',
            salaryFrom: Money.fromIntWithCurrency(100000, CommonCurrencies().usd),
            salaryTo: Money.fromIntWithCurrency(200000, CommonCurrencies().usd),
            created: now,
            updated: now,
          );
          final json = sourceSalary.toJson();
          final salary = Job.fromJson(json);
          expect(salary.salaryFrom, sourceSalary.salaryFrom);
          expect(salary.salaryTo, sourceSalary.salaryTo);
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
