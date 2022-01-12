import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

/// TODO: подсказывать страну по геолокации, последние выбраные
/// TODO: на больших экранах отображать дропдаун с поиском
@immutable
class CountryPicker extends StatelessWidget {
  const CountryPicker({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<Country> controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextButton(
            onPressed: () => _openSelectionPage(context),
            child: ValueListenableBuilder<Country>(
              valueListenable: controller,
              builder: (context, value, child) => Text(
                value.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );

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

const IconData _kKeyboardArrowDownIcon = Icons.keyboard_arrow_down;

class _CountrySearchDelegate extends SearchDelegate<Country?> {
  _CountrySearchDelegate(this.current);
  final List<Country> all = Countries.values.values.toList(growable: false);
  final Country current;

  @override
  List<Widget> buildActions(BuildContext context) => [
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
        padding: EdgeInsets.symmetric(
          horizontal: math.max<double>(
            (MediaQuery.of(context).size.width - kBodyWidth) / 2,
            8,
          ),
          vertical: 8,
        ),
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
      title: Text(
        country.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          height: 1,
        ),
      ),
      trailing: selected
          ? const Icon(
              _kCheckIcon,
            )
          : const SizedBox.shrink(),
      onTap: onTap,
    );
  }
}

const IconData _kCheckIcon = Icons.check;
