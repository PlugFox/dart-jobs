import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_employment_filter.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_level_filter.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_relocation_filter.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_remote_filter.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/country_picker.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class FeedFilterBottomSheet extends StatefulWidget {
  const FeedFilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedFilterBottomSheet> createState() => _FeedFilterBottomSheetState();
}

class _FeedFilterBottomSheetState extends State<FeedFilterBottomSheet> {
  late final JobFilter filter;
  final ValueNotifier<String?> _errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<Country> _countryController = ValueNotifier<Country>(Countries.unknown);
  final ValueNotifier<bool?> _remoteController = ValueNotifier<bool?>(null);
  final ValueNotifier<DeveloperLevel?> _levelController = ValueNotifier<DeveloperLevel?>(null);
  final ValueNotifier<Employment?> _employmentController = ValueNotifier<Employment?>(null);
  final ValueNotifier<bool?> _relocationController = ValueNotifier<bool?>(null);

  @override
  void initState() {
    super.initState();
    filter = BlocProvider.of<FeedBLoC>(context).state.filter;
    _reset();
  }

  @override
  void dispose() {
    _errorNotifier.dispose();
    _countryController.dispose();
    _remoteController.dispose();
    _levelController.dispose();
    _employmentController.dispose();
    _relocationController.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    final newFilter = filter.copyWith(
      country: _countryController.value.isExist ? _countryController.value.code : null,
      relocation: _relocationController.value,
      level: _levelController.value,
      remote: _remoteController.value,
      employment: _employmentController.value,
    );
    if (newFilter != filter) {
      FeedScope.setFilterOf(
        context,
        (filter) => newFilter,
      );
    }
    Navigator.pop(context);
  }

  void _reset() {
    _countryController.value = Country.byCode(filter.country);
    _remoteController.value = filter.remote;
    _levelController.value = filter.level;
    _employmentController.value = filter.employment;
    _relocationController.value = filter.relocation;
  }

  void _unselectAll() {
    _countryController.value = Countries.unknown;
    _remoteController.value = null;
    _levelController.value = null;
    _employmentController.value = null;
    _relocationController.value = null;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // 620 px - max width
    final horizontalPadding = math.max<double>(
      (mediaQuery.size.width - kBodyWidth) / 2,
      8,
    );
    return SizedBox(
      height: math.min(mediaQuery.size.height - kToolbarHeight, 620),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 24,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFD6DBE0),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: SizedBox(
                  width: 38,
                  height: 4,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 300,
                    child: CountryPicker(controller: _countryController, error: _errorNotifier),
                  ),
                ),
                const SizedBox(height: 12),
                FeedRemoteFilter(controller: _remoteController),
                const SizedBox(height: 12),
                FeedLevelFilter(controller: _levelController),
                const SizedBox(height: 12),
                FeedRelocationFilter(controller: _relocationController),
                const SizedBox(height: 12),
                FeedEmploymentFilter(controller: _employmentController),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).primaryTextTheme.button,
                      ),
                      onPressed: _unselectAll, // Navigator.pop(context),
                      icon: const Icon(Icons.restore),
                      label: Text(
                        context.localization.filter_button_reset,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).primaryTextTheme.button,
                      ),
                      onPressed: () => _save(context),
                      icon: const Icon(Icons.save),
                      label: Text(
                        context.localization.filter_button_search,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
