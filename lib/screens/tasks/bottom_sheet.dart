import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_project/shared/styles/colors.dart';

class TaskBottomSheet extends StatefulWidget{
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Task",
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text("Task Title"),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              label: Text("Task Description"),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Selected Date",
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height:20,
          ),
          InkWell(
            onTap: () {
              selectDate(context);
            },
            child: Text(
              selectedDate.toString().substring(0,10),
              style: GoogleFonts.poppins(
                color: primaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height:20,
          ),
          ElevatedButton(onPressed: () {

          },
              style:ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(12),
                ))

                ),
              child: Text("add Task",style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),))
        ],
      ),
    );
  }

  selectDate(BuildContext context) async{
   DateTime? chosenDate= await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
   if(chosenDate==null){
     return;
   }
   selectedDate=chosenDate;
   setState(() {
   });
  }
}
