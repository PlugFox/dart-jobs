import 'package:flutter/material.dart';

@immutable
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required final this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 16,
          bottom: 24,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
}
