import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class FeedSearchBar extends StatelessWidget implements PreferredSizeWidget {
  static const Size searchBarSize = Size.fromHeight(kToolbarHeight);

  @override
  Size get preferredSize => searchBarSize;

  const FeedSearchBar({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox.fromSize(
        size: searchBarSize,
        child: const Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Center(
            child: FocusScope(
              child: SizedBox(height: kToolbarHeight - 8, width: kBodyWidth, child: _FilterButton()),
              /*
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Expanded(child: SizedBox(height: kToolbarHeight - 8, child: _FilterButton())),
                  SizedBox.square(dimension: kToolbarHeight - 8, child: _FilterButton()),
                  Expanded(child: _SearchBar()),
                  SizedBox(width: 3),
                  SizedBox.square(dimension: kToolbarHeight - 8, child: _SearchButton()),
                ],
              ),
              */
            ),
          ),
        ),
      );
}

@immutable
class _FilterButton extends StatelessWidget {
  const _FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        AppRouter.showBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          builder: (_) => const FeedFilterBottomSheet(),
        );
        //Navigator.of(context, rootNavigator: false).push<void>(FeedFilterPageRoute());
      },
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(9),
            bottomRight: Radius.circular(3),
            bottomLeft: Radius.circular(9),
          ),
        ),
        alignment: Alignment.center,
        primary: theme.splashColor,
        //padding: EdgeInsets.zero,
        //fixedSize: Size(double.infinity, kToolbarHeight - 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox.square(
            dimension: 28,
            child: Icon(
              Icons.filter_alt,
              size: 28,
              color: theme.primaryIconTheme.color,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                context.localization.filter,
                style: theme.primaryTextTheme.button?.copyWith(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox.square(
            dimension: 28,
            child: CircleAvatar(
              child: BlocBuilder<FeedBLoC, FeedState>(
                buildWhen: (prev, next) => !next.isProcessed,
                builder: (context, state) => Text(
                  state.filter.count.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.button?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
@immutable
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputDecorationBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: BorderSide(
        width: 3,
        style: BorderStyle.solid,
        color: Theme.of(context).dividerColor,
      ),
    );
    return Opacity(
      opacity: .5,
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          keyboardType: TextInputType.text,
          maxLines: 1,
          minLines: 1,
          textAlign: TextAlign.left,
          maxLength: 120,
          autofocus: false,
          style: Theme.of(context).primaryTextTheme.button?.copyWith(
                fontSize: 24,
              ),
          onChanged: null,
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Not implemented yet...',
            filled: true,
            fillColor: Theme.of(context).backgroundColor,
            contentPadding: const EdgeInsets.all(6),
            focusedBorder: inputDecorationBorder,
            enabledBorder: inputDecorationBorder,
            disabledBorder: inputDecorationBorder,
            border: inputDecorationBorder,
          ),
        ),
      ),
    );
  }
}

@immutable
class _SearchButton extends StatelessWidget {
  const _SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: .5,
        child: AbsorbPointer(
          absorbing: true,
          child: OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(3),
                  right: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              primary: Theme.of(context).splashColor,
              padding: EdgeInsets.zero,
              fixedSize: const Size.square(kToolbarHeight - 8),
            ),
            child: Icon(
              Icons.search,
              size: 24,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ),
      );
}
*/
