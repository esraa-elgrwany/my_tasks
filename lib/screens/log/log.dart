import 'package:flutter/material.dart';
import 'package:todo_project/screens/log/login_tab.dart';
import 'package:todo_project/screens/log/signUp_tab.dart';

class LogScreen extends StatelessWidget{
  static const String routeName="login";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(""),
          bottom: TabBar(tabs:[
              Tab(
                child: Text("Login", style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:Colors.white)),
              ),
            Tab(
              child: Text("Sign up", style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white
              )),
            )
            ]
          ),
        ),
        body: TabBarView(children: [
          LoginTab(),
          SignUpTab(),
        ]
        ),
      ),
    );
  }
}
