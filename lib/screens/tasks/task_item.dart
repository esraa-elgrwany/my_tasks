import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_project/models/taskmodel.dart';
import 'package:todo_project/screens/editScreen.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/styles/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(
            color: primaryColor,
                width:2.w
          )
        ),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                FireBaseFunctions.deleteTask(taskModel.id);
              },
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r)),
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
              label: AppLocalizations.of(context)!.edit,
              backgroundColor:primaryColor
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color:  Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(taskModel.title,style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary
                      )),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(taskModel.description,style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface
                      )),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined,
                            color:Theme.of(context).colorScheme.secondary,),
                          SizedBox(width: 8.w,),
                          Text("10:40",style: TextStyle(
                            color:  Theme.of(context).colorScheme.secondary
                          ),),
                        ],
                      )
                    ],
                  ),
                Spacer(),
                taskModel.isDone
                    ? Container(
                        width: 69.w,
                        height: 34.h,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.r)),
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
                            width: 69.w,
                            height: 34.h,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8.r)),
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
