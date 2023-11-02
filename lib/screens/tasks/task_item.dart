import 'package:flutter/material.dart';
import 'package:todo_project/models/taskmodel.dart';
import 'package:todo_project/screens/editScreen.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/styles/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                FireBaseFunctions.deleteTask(taskModel.id);
              },
              icon: Icons.delete,
              label: "Delete",
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(taskModel),
                    ));
              },
              icon: Icons.edit,
              label: "Edit",
              backgroundColor: Colors.blue,
            )
          ]),
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
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(taskModel.title),
                    Text(taskModel.description),
                  ],
                ),
                Spacer(),
                taskModel.isDone
                    ? Container(
                        width: 69,
                        height: 34,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        )))
                    : InkWell(
                        onTap: () {
                          taskModel.isDone = true;
                          FireBaseFunctions.updateTask(taskModel);
                        },
                        child: Container(
                            width: 69,
                            height: 34,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
