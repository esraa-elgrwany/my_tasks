import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/models/usermodel.dart';
import 'package:todo_project/screens/log/log.dart';
import 'package:todo_project/screens/log/login_tab.dart';
import 'package:todo_project/screens/setting/setting_tab.dart';
import 'package:todo_project/screens/tasks/bottom_sheet.dart';
import 'package:todo_project/screens/tasks/tasks_tab.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          toolbarHeight: 100,
          title: index == 0
              ? Row(
                children: [
                  Text(
                      AppLocalizations.of(context)!.appTitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                ],
              )
              : Text(
                  AppLocalizations.of(context)!.setting,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, LogScreen.routeName, (route) => false);
            },
              icon: Icon(Icons.logout)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSheet();
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: CircleBorder(
              side: BorderSide(
            color: Theme.of(context).colorScheme.surface,
            width: 4,
          )),
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Theme.of(context).colorScheme.surface,
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: "")
            ]),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingTab()];

  showSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TaskBottomSheet(),
      ),
    );
  }
}
