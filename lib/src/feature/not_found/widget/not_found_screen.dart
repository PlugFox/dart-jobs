import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/router/page_router.dart';

@immutable
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('404: Not found'),
        ),
        body: SafeArea(
          child: Center(
            child: TextButton(
              onPressed: () => PageRouter.maybePop(context).then<void>(
                (value) {
                  if (!value) {
                    PageRouter.goHome(context);
                  }
                },
              ),
              child: Text('Go ${PageRouter.canPop(context) ? 'back' : 'home'}'),
            ),
          ),
        ),
      );
}
