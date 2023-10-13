import 'package:flutter/material.dart';
import 'package:todo_project/shared/styles/colors.dart';

class TaskItem extends StatelessWidget{
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:12,horizontal:18),
      child: Card(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15)
       ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 70,
                decoration: BoxDecoration(
                  color: primaryColor,
                    borderRadius: BorderRadius.circular(18),
                ),
              ),
              SizedBox(width:20,),
              Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task title"),
                  Text("Task description"),
                ],
              ),Spacer(),
              Icon(Icons.done),
            ],
          ),
        ),
      ),
    );
  }
}
