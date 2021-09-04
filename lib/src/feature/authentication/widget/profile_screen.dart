import 'package:flutter/material.dart';

import 'profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const SafeArea(
          child: _ProfileBody(),
        ),
      );
}

@immutable
class _ProfileBody extends StatefulWidget {
  const _ProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody> {
  @override
  Widget build(BuildContext context) => const ProfileWidget();
}
