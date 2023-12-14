import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/colors.dart';
import 'package:todo_project/shared/styles/my_theme.dart';

class LanguageBottomSheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
             provider.changeLanguage("en");
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.en,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!.copyWith(
                    color:Theme.of(context).colorScheme.onPrimary
                  )

                ),
                Spacer(),
                (provider.languageCode == "en")
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
              provider.changeLanguage("ar");
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.ar,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary
                  )

                ),
                Spacer(),
                (provider.languageCode == "en")
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
