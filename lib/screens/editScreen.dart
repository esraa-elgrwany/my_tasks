import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_project/layout/home_layout.dart';
import 'package:todo_project/models/taskmodel.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/styles/colors.dart';

class EditScreen extends StatefulWidget {
  //static const String routeName = "editScreen";
 final TaskModel taskModel;
  EditScreen(this.taskModel);
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  late DateTime selectedDate ;

  var formKey = GlobalKey<FormState>();
@override
void initState() {
    super.initState();
    titleController.text=widget.taskModel.title;
    descriptionController.text=widget.taskModel.description;
    selectedDate=DateTime.fromMillisecondsSinceEpoch(widget.taskModel.date);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            AppLocalizations.of(context)!.appTitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color:  Theme.of(context).colorScheme.onPrimary
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Edit Task",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
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
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      label: Text("Task Title",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
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
                    height: 20.h,
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
                      suffixIcon: Icon(Icons.edit,color:Theme.of(context).
                      colorScheme.onPrimary ,),
                      label: Text("Task Description",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
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
                    height: 20.h,
                  ),
                  Text("Selected Date",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Center(
                      child: Text(
                        selectedDate.toString().substring(0, 10),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            TaskModel taskModel = TaskModel(
                                title: titleController.text,
                                description: descriptionController.text,
                                date: DateUtils.dateOnly(selectedDate)
                                    .millisecondsSinceEpoch,
                            userId:widget.taskModel.userId,
                              id: widget.taskModel.id,
                              isDone:widget.taskModel.isDone
                            );
                            FireBaseFunctions.updateTask(taskModel);
                            Navigator.pop(context);

                        }},
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal:34 ,vertical: 8),
                            ),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(12.r),
                                  side: BorderSide(color: Theme.of(context).
                                  colorScheme.onPrimary)
                            ))),
                        child: Text("Save Changes",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white))),
                  ),
                 SizedBox(height: 40.h,)
                ],
              ),
            ),
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
    selectedDate =DateUtils.dateOnly(chosenDate) ;
    setState(() {});
  }
}
