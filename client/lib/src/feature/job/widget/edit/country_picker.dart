import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

/// TODO: подсказывать страну по геолокации, последние выбраные
/// TODO: на больших экранах отображать дропдаун с поиском
@immutable
class CountryPicker extends StatelessWidget {
  const CountryPicker({
    required final this.controller,
    required final this.error,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<Country> controller;
  final ValueNotifier<String?> error;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          _openSelectionPage(context);
          FocusScope.of(context).unfocus();
        },
        child: ValueListenableBuilder<Country>(
          valueListenable: controller,
          builder: (context, value, child) => ValueListenableBuilder<String?>(
            valueListenable: error,
            builder: (context, errorText, child) => SizedBox(
              height: errorText == null ? 60 : 80,
              child: InputDecorator(
                isFocused: false,
                expands: true,
                isHovering: true,
                decoration: InputDecoration(
                  labelText: context.localization.job_field_location_country,
                  errorText: errorText,
                ),
                isEmpty: !value.isExist,
                child: child,
              ),
            ),
            child: Text(
              value.isExist ? value.title : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: themeData.textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  void _openSelectionPage(BuildContext context) => showSearch<Country?>(
        context: context,
        delegate: _CountrySearchDelegate(controller.value),
      ).then<void>(
        (value) {
          if (value != null) {
            controller.value = value;
          }
        },
      );
}

class _CountrySearchDelegate extends SearchDelegate<Country?> {
  _CountrySearchDelegate(this.current)
      : super(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.search,
        ) {
    all
      ..add(current)
      ..addAll(Countries.values.values.where((e) => e.id != current.id));
  }

  final List<Country> all = <Country>[];
  final Country current;

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        if (query.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => query = '',
          ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => build(
        context,
        query.length < 2
            ? all
            : all.where((e) => e.title.toLowerCase().contains(query.toLowerCase())).toList(growable: false),
      );

  @override
  Widget buildSuggestions(BuildContext context) => build(
        context,
        query.length < 2
            ? all
            : all.where((e) => e.title.toLowerCase().contains(query.toLowerCase())).toList(growable: false),
      );

  Widget build(BuildContext context, List<Country> countries) => ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: countries.length,
        itemExtent: 55,
        itemBuilder: (context, index) {
          final country = countries[index];
          return _CountryTile(
            country: country,
            selected: country == current,
            isOdd: index.isOdd,
            onTap: () => close(context, country),
          );
        },
      );
}

@immutable
class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required final this.country,
    required final this.onTap,
    final this.isOdd = false,
    final this.selected = false,
    Key? key,
  }) : super(key: key);

  final Country country;
  final VoidCallback? onTap;
  final bool selected;
  final bool isOdd;

  @override
  Widget build(BuildContext context) {
    final tileColor = isOdd ? ListTileTheme.of(context).tileColor : Theme.of(context).highlightColor;
    return ListTile(
      style: ListTileStyle.list,
      iconColor: Colors.green,
      selected: selected,
      tileColor: tileColor,
      selectedTileColor: tileColor,
      contentPadding: EdgeInsets.symmetric(
        horizontal: math.max<double>(
          (MediaQuery.of(context).size.width - kBodyWidth) / 2,
          8,
        ),
        vertical: 0,
      ),
      title: Text(
        country.isExist ? country.title : context.localization.job_field_location_country_unknown,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          height: 1,
        ),
      ),
      trailing: selected
          ? const Icon(
              Icons.check,
            )
          : const SizedBox.shrink(),
      onTap: onTap,
    );
  }
}
