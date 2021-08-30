import 'package:flutter/widgets.dart';

@immutable
class GlobalContext extends StatefulWidget {
  const GlobalContext({
    required final this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<GlobalContext> createState() => _GlobalContextState();
}

class _GlobalContextState extends State<GlobalContext> {
  @override
  Widget build(BuildContext context) => const Placeholder();
}
