import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/screens/setting/languagebottomsheet.dart';
import 'package:todo_project/screens/setting/themingbottomsheet.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/my_theme.dart';

import '../../shared/styles/colors.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return
      Container(
        margin: EdgeInsets.only(top: 40),
        height: MediaQuery
            .of(context)
            .size
            .height * .65,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Card(
            elevation: 10,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2.w,
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.en, style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary
                          )),
                          SizedBox(height: 6.h,),
                          Text(AppLocalizations.of(context)!.lang,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface,
                                fontSize: 16.sp
                            ),
                          ),
                          SizedBox(height: 6.h,),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.language, color: Theme
                          .of(context)
                          .colorScheme
                          .secondary, size: 30,)
                    ],
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    color: primaryColor,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.translate, style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary
                          )),
                          SizedBox(height: 6.h,),
                          Text(AppLocalizations.of(context)!.ar,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface,
                                fontSize: 16.sp
                            ),
                          ),
                          SizedBox(height: 6.h,),
                        ],
                      ),
                      Spacer(),
                      Switch(value:pro.isArabic,
                        onChanged: (value) {
                          pro.isArabic = value;
                          if(pro.isArabic==true){
                            pro.changeLanguage("ar");
                          }else{
                            pro.changeLanguage("en");
                          }
                        },
                      ),
                    ],
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    color: primaryColor,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.light, style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary
                          )),
                          SizedBox(height: 6.h,),
                          Text(AppLocalizations.of(context)!.theme,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface,
                                fontSize: 16.sp
                            ),
                          ),
                          SizedBox(height: 6.h,),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.sunny, color: Theme
                          .of(context)
                          .colorScheme
                          .secondary, size: 30,)
                    ],
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    color: primaryColor,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.dark, style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary
                          )),
                          SizedBox(height: 6.h,),
                        ],
                      ),
                      Spacer(),
                      Switch(value: pro.isDark,
                        onChanged: (value) {
                        pro.isDark=value;
                        if(pro.isDark==true){
                        pro.changeMode(ThemeMode.dark);
                        }else{
                          pro.changeMode(ThemeMode.light);
                        }
                        setState(() {
                        });
                      },)
                    ],
                  ),
                  /* Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: primaryColor,
                        width: 2
                      )),
                  child: Row(
                    children: [
                      Text(pro.languageCode=="en"?AppLocalizations.of(context)!.en
                          :AppLocalizations.of(context)!.ar,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Theme.of(context).colorScheme.onSurface

                          )),
                      Spacer(),
                      InkWell(
                          onTap: showLangugeBottomSheet,
                          child: Icon(Icons.arrow_drop_down,size: 30,color:Theme.of(context).colorScheme.onPrimary,)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(AppLocalizations.of(context)!.theme,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: Theme.of(context).colorScheme.onPrimary
    )),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: primaryColor,
                      width: 2)),
                  child: Row(
                    children: [
                      Text(pro.modeApp==ThemeMode.light?AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Theme.of(context).colorScheme.onSurface)),
                      Spacer(),
                      InkWell(
                          onTap: showThemingBottomSheet,
                          child: Icon(Icons.arrow_drop_down,size: 30,color:Theme.of(context).colorScheme.onPrimary,)),
                    ],
                  ),
                ),*/
                ],
              ),
            ),
          ),
        ),
      );
  }
}

