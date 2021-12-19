import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form/job_form.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form/job_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobDescriptionsField extends StatefulWidget {
  const JobDescriptionsField(
    final this.label,
    final this.controller, {
    final Key? key,
  }) : super(key: key);

  final String label;
  final JobFieldDescriptionsController controller;

  @override
  State<StatefulWidget> createState() => _JobDescriptionsFieldState();
}

class _JobDescriptionsFieldState extends State<JobDescriptionsField> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isRussian = context.locale == const Locale('ru');
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: scaffoldWidth,
        maxHeight: 300,
      ),
      child: ValueListenableBuilder<String?>(
        valueListenable: widget.controller.error,
        builder: (context, errorText, _) => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 35,
              child: TabBar(
                controller: _tabController,
                labelColor: themeData.hintColor,
                indicatorColor: themeData.indicatorColor,
                tabs: isRussian
                    ? <Widget>[
                        Tab(
                          text: context.localization.russian,
                        ),
                        Tab(
                          text: context.localization.english,
                        ),
                      ]
                    : <Widget>[
                        Tab(
                          text: context.localization.english,
                        ),
                        Tab(
                          text: context.localization.russian,
                        ),
                      ],
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: isRussian
                    ? <Widget>[
                        _JobMultiLineDescription(
                          widget.controller.russian,
                          maxLength: widget.controller.maxLength,
                          inputFormatters: const <TextInputFormatter>[],
                        ),
                        _JobMultiLineDescription(
                          widget.controller.english,
                          maxLength: widget.controller.maxLength,
                          inputFormatters: <TextInputFormatter>[
                            _denyCyrillic,
                          ],
                        ),
                      ]
                    : <Widget>[
                        _JobMultiLineDescription(
                          widget.controller.english,
                          maxLength: widget.controller.maxLength,
                          inputFormatters: <TextInputFormatter>[
                            _denyCyrillic,
                          ],
                        ),
                        _JobMultiLineDescription(
                          widget.controller.russian,
                          maxLength: widget.controller.maxLength,
                          inputFormatters: const <TextInputFormatter>[],
                        ),
                      ],
              ),
            ),
            SizedBox(
              height: 15,
              child: errorText != null
                  ? Text(
                      errorText,
                      style: themeData.textTheme.caption?.copyWith(
                        color: themeData.errorColor,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Не разрешать ввод кирилицы
final TextInputFormatter _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-ЯёЁ]'));

class _JobMultiLineDescription extends StatelessWidget {
  const _JobMultiLineDescription(
    final this.controller, {
    this.inputFormatters = const <TextInputFormatter>[],
    this.maxLength = 2600,
    final Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;

  @override
  Widget build(final BuildContext context) => ValueListenableBuilder<FormStatus>(
        valueListenable: JobForm.formDataOf(context).status,
        builder: (context, status, _) => Opacity(
          opacity: status == FormStatus.processed ? 0.5 : 1,
          child: TextField(
            controller: controller,
            enabled: status == FormStatus.editing,
            readOnly: status != FormStatus.editing,
            minLines: 15,
            maxLines: 30,
            maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: context.localization.job_field_description,
              border: status != FormStatus.editing ? InputBorder.none : null,
              filled: true,
              fillColor: Theme.of(context).highlightColor,
            ),
            inputFormatters: <TextInputFormatter>[
              //LengthLimitingTextInputFormatter(maxLength),
              ...inputFormatters,
            ],
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ),
      );
}
