import 'package:flutter/material.dart';
import 'package:todo_project/screens/setting/setting_tab.dart';
import 'package:todo_project/screens/tasks/bottom_sheet.dart';
import 'package:todo_project/screens/tasks/tasks_tab.dart';
import 'package:todo_project/shared/styles/my_theme.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "To Do List",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSheet();
          },
          shape: CircleBorder(
              side: BorderSide(
            color: Colors.white,
            width: 3,
          )),
          child: Icon(Icons.add)),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
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
        padding:  EdgeInsets.only(bottom:
            MediaQuery.of(context).viewInsets.bottom
        ),
        child: TaskBottomSheet(),
      ),
    );
  }
}
