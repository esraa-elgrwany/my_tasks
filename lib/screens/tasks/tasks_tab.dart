import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/models/taskmodel.dart';
import 'package:todo_project/screens/tasks/task_item.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/styles/colors.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              selectedDate =date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor:  Theme.of(context).colorScheme.onPrimary,
            dayColor:  Theme.of(context).colorScheme.onPrimary,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: primaryColor,
            dotsColor: Colors.white,
            selectableDayPredicate: (date) => true,
            locale: 'en',
          ),
          StreamBuilder(
            stream: FireBaseFunctions.getTask(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("something went wrong",style: TextStyle(
                  color:  Theme.of(context).colorScheme.onPrimary
                ),));
              }
             // print(snapshot.data?.docs.length ?? '###');
              List<TaskModel> tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if(tasks.isEmpty){
               return Center(child: Text("No tasks",style: TextStyle(
                   color:  Theme.of(context).colorScheme.onPrimary)));
              }
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(taskModel: tasks[index]);
                  },
                  itemCount: tasks.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
