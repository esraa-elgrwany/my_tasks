import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/screens/tasks/task_item.dart';
import 'package:todo_project/shared/styles/colors.dart';

class TasksTab extends StatelessWidget{
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: primaryColor,
          dayColor: primaryColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.redAccent[100],
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder:(context, index) => TaskItem(),
            itemCount: 8,
          ),
        ),
      ],
    );
  }
}
