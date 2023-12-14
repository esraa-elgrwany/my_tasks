import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_project/models/taskmodel.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskBottomSheet extends StatefulWidget {
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();

 var descriptionController = TextEditingController();

  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter task title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit,color: Theme
                      .of(context)
                      .colorScheme
                      .secondary ,),
                  label: Text(AppLocalizations.of(context)!.taskTitle,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface,)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.w,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter task description";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit,color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,),
                  label: Text(AppLocalizations.of(context)!.taskDescription,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface,)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.selectedDate,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:  Theme.of(context).colorScheme.onPrimary)),
                  SizedBox(width: 8.w,),
                  Icon(Icons.date_range,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  selectDate(context);
                },
                child: Text(
                  selectedDate.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color:   Theme.of(context).colorScheme.onSurface
                  ),
                  textAlign: TextAlign.center,

                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        TaskModel taskModel = TaskModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                        );
                        FireBaseFunctions.addTask(taskModel);

                        Navigator.pop(context);

                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 40)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(12),
                    ))),
                    child: Text(AppLocalizations.of(context)!.addTask,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white))),
              )
            ],
          ),
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;

    setState(() {});
  }
}
