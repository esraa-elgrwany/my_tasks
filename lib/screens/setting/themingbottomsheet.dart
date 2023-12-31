import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/my_theme.dart';

import '../../shared/styles/colors.dart';


class ThemingBottomSheet extends StatelessWidget{
  const ThemingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeMode(ThemeMode.light);
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!.copyWith(
                      color:Theme.of(context).colorScheme.onPrimary
                  )
                ),
                Spacer(),
                (provider.modeApp==ThemeMode.
                light)
                    ? Icon(Icons.done,
                    size: 25, color:Theme.of(context).colorScheme.onPrimary)
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Divider(
            color: primaryColor,
            thickness: 2,
            indent: 40,
            endIndent: 40,
          ),
          InkWell(
            onTap: () {
              provider.changeMode(ThemeMode.dark);
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.dark,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!.copyWith(
                      color:Theme.of(context).colorScheme.onPrimary
                  )
                ),
                Spacer(),
                (provider.modeApp==ThemeMode.light)
                    ? SizedBox.shrink()
                    : Icon(
                  Icons.done,
                  color:Theme.of(context).colorScheme.onPrimary,
                  size: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}