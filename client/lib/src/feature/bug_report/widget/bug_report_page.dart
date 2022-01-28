import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/pages.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/common/widget/error_snackbar.dart';
import 'package:dart_jobs_client/src/common/widget/successful_snackbar.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/bug_report/bloc/bug_report_bloc.dart';
import 'package:dart_jobs_client/src/feature/bug_report/model/bug_report_entity.dart';
import 'package:dart_jobs_client/src/feature/bug_report/widget/bug_report_description_input.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Страница работы
class BugReportPage extends AppPage<void> {
  BugReportPage(String name)
      : super(
          location: name,
          name: name,
        );

  @override
  bool canUpdate(Page<Object?> other) {
    if (other is! BugReportPage) return false;
    return other.name == name && other.arguments == arguments;
  }

  @override
  Widget builder(BuildContext context) {
    AuthenticationScope.authenticatedOrNullOf(context);
    return BlocProvider<BugReportBLoC>(
      create: (context) => BugReportBLoC(
        repository: RepositoryScope.of(context).bugReportRepository,
      ),
      child: const _BugReportScreen(),
    );
  }
}

@immutable
class _BugReportScreen extends StatelessWidget {
  const _BugReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        maintainBottomViewPadding: false,
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            context.localization.bug_report_title,
            maxLines: 1,
          ),
        ),
        body: BlocListener<BugReportBLoC, BugReportState>(
          listener: (context, state) => state.maybeMap<void>(
            orElse: () {},
            error: (state) => ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(
                error: state.message,
              ),
            ),
            successful: (state) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SuccessfulSnackBar(
                  message: state.message,
                ),
              );
            },
          ),
          child: const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: FocusScope(
                child: _BugReportForm(),
              ),
            ),
          ),
        ),
      );
}

@immutable
class _BugReportForm extends StatefulWidget {
  const _BugReportForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_BugReportForm> createState() => _BugReportFormState();
}

class _BugReportFormState extends State<_BugReportForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<BugReportType?> _typeController = ValueNotifier<BugReportType?>(null);
  late final Listenable _changeListenable;

  bool get _preparedToSend => _descriptionController.text.isNotEmpty && _typeController.value != null;

  @override
  void initState() {
    _changeListenable = Listenable.merge(
      <Listenable>[
        _descriptionController,
        _typeController,
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 620 px - max width
    final horizontalPadding = math.max<double>(
      (MediaQuery.of(context).size.width - kBodyWidth) / 2,
      8,
    );
    return Stack(
      children: <Positioned>[
        Positioned.fill(
          child: Align(
            alignment: const Alignment(0, -.66),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                top: 14,
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 80,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        context.localization.bug_report_i_would_like_to,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      _BugReportDropDownButton(
                        typeController: _typeController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  //Text(
                  //  context.localization.bug_report_description,
                  //  style: Theme.of(context).textTheme.subtitle1,
                  //),
                  //const SizedBox(height: 12),
                  BugReportDescriptionInput(
                    controller: _descriptionController,
                    title: context.localization.bug_report_description,
                    label: context.localization.bug_report_leave_a_description,
                    hint: context.localization.bug_report_leave_a_description,
                    denyCyrillic: false,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 12,
          right: 12,
          height: 48,
          child: AnimatedBuilder(
            animation: _changeListenable,
            builder: (context, child) => ElevatedButton(
              onPressed: _preparedToSend
                  ? () {
                      FocusScope.of(context).unfocus();
                      final message = _descriptionController.text;
                      final type = _typeController.value;
                      if (message.isEmpty || type == null) return;
                      final user = AuthenticationScope.authenticatedOrNullOf(context);
                      BlocProvider.of<BugReportBLoC>(context).add(
                        BugReportEvent.send(
                          BugReportEntity(
                            message: message,
                            type: type,
                            email: user?.email,
                            userId: user?.uid,
                          ),
                        ),
                      );
                    }
                  : null,
              child: child,
            ),
            child: Text(context.localization.send_bug_report),
          ),
        ),
      ],
    );
  }
}

@immutable
class _BugReportDropDownButton extends StatelessWidget {
  const _BugReportDropDownButton({
    required final this.typeController,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<BugReportType?> typeController;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<BugReportType?>(
        valueListenable: typeController,
        builder: (context, value, child) => DropdownButton<BugReportType>(
          value: value,
          icon: child,
          items: <DropdownMenuItem<BugReportType>>[
            DropdownMenuItem(
              value: BugReportType.feature,
              child: Text(
                _localizeType(context, BugReportType.feature),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownMenuItem(
              value: BugReportType.improvement,
              child: Text(
                _localizeType(context, BugReportType.improvement),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownMenuItem(
              value: BugReportType.bug,
              child: Text(
                _localizeType(context, BugReportType.bug),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          onChanged: (type) => typeController.value = type,
        ),
        child: const Icon(Icons.arrow_downward),
      );

  String _localizeType(BuildContext context, BugReportType? type) {
    switch (type) {
      case BugReportType.feature:
        return context.localization.bug_report_feature;
      case BugReportType.improvement:
        return context.localization.bug_report_request_an_improvement;
      case BugReportType.bug:
        return context.localization.bug_report_report_an_issue;
      default:
        return context.localization.bug_report_select_an_option;
    }
  }
}
