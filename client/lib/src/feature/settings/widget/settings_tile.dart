import 'package:flutter/material.dart';

@immutable
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required final this.title,
    final this.leading,
    final this.subtitle,
    final this.enabled = true,
    final this.trailing,
    final this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final bool enabled;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        enabled: enabled,
        trailing: trailing,
        onTap: enabled ? onTap : null,
      );
}
