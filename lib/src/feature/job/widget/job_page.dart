import 'package:flutter/material.dart';

class JobPage extends Page<void> {
  JobPage({
    required final this.id,
    required final this.title,
    final this.edit = false,
  }) : super(
          key: ValueKey<String>('/job/$id'),
          name: '/job/$id',
          arguments: <String, Object?>{
            'id': id,
            'edit': edit,
          },
        );

  /// Идентификатор работы
  final String id;

  /// Заголовок работы
  final String title;

  /// Открыть в режиме редактирования, а не просмотра
  final bool edit;

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => const Placeholder(),
        settings: this,
      );
}
