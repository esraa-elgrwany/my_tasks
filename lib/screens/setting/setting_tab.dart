import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/screens/setting/languagebottomsheet.dart';
import 'package:todo_project/screens/setting/themingbottomsheet.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/my_theme.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return
     Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.lang,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
              )
                  ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              color:Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.blue,
                  width: 2
                )),
            child: Row(
              children: [
                Text(pro.languageCode=="en"?AppLocalizations.of(context)!.en
                    :AppLocalizations.of(context)!.ar,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary

                    )),
                Spacer(),
                InkWell(
                    onTap: showLangugeBottomSheet,
                    child: Icon(Icons.arrow_drop_down,size: 30,color: MyThemeData.lightTheme.primaryColor,)),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: Theme.of(context).colorScheme.onSurface
    )),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color:Colors.blue,
                width: 2)),
            child: Row(
              children: [
                Text(pro.modeApp==ThemeMode.light?AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary)),
                Spacer(),
                InkWell(
                    onTap: showThemingBottomSheet,
                    child: Icon(Icons.arrow_drop_down,size: 30,color: MyThemeData.lightTheme.primaryColor,)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showLangugeBottomSheet() {
    showModalBottomSheet(
      context: context,
      //isScrollControlled: true,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent)),
      builder: (context) => LanguageBottomSheet(),
    );
  }

  showThemingBottomSheet() {
    showModalBottomSheet(
      context: context,
      //isScrollControlled: true,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent)),
      builder: (context) => ThemingBottomSheet(),
    );
  }
}

