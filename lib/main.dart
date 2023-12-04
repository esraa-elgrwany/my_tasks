import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_project/layout/home_layout.dart';
import 'package:todo_project/screens/log/login_tab.dart';
import 'package:todo_project/screens/log/signUp_tab.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/my_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MyProvider(),),
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(412,870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(context, child) =>
      MaterialApp(
        supportedLocales:AppLocalizations.supportedLocales,
        localizationsDelegates:AppLocalizations.localizationsDelegates,
        locale: Locale(pro.languageCode),
        debugShowCheckedModeBanner: false,
        initialRoute:pro.firebaseUser!=null? HomeLayout.routeName
        :LoginTab.routeName,
        routes: {
          HomeLayout.routeName:(context) => HomeLayout(),
          LoginTab.routeName:(context) => LoginTab(),
          SignUpTab.routeName:(context) => SignUpTab()
        },
        themeMode:pro.modeApp ,
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme,
      ),
    );
  }
}


