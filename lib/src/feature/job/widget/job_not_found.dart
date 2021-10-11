import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/router/page_router.dart';

@immutable
class JobNotFound extends StatelessWidget {
  const JobNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('NOT FOUND'),
        ),
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                Center(
                  child: Text(
                    'JOB NOT FOUND',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: IconButton(
                    onPressed: () => PageRouter.goHome(context),
                    icon: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    ),
                    iconSize: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
