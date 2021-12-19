import 'package:dart_jobs_client/src/common/constant/assets.gen.dart' as assets;
import 'package:flutter/material.dart';

@immutable
class DartLogoIcon extends StatelessWidget {
  const DartLogoIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox.square(
          dimension: 42,
          child: Card(
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: const assets.$AssetsImageGen().dartLogo.dartLogoToolbar.image(),
            ),
          ),
        ),
      );
}
