import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;


  HabitTile(
      {required this.habitName,
      required this.habitCompleted,
      required this.onChanged,
      required this.deleteTapped,
      required this.settingsTapped,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit_rounded,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete_rounded,
              borderRadius: BorderRadius.circular(12),
            )   ,
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: habitCompleted? Color(0xff2a6f97):Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: habitCompleted,
                onChanged: onChanged,
                fillColor: MaterialStateProperty.all<Color>(Color(0xff013a63)),
              ),
              Text(habitName, style: GoogleFonts.raleway(textStyle: TextStyle(color: habitCompleted? Colors.white: Colors.black, fontSize: 16.0),),),
              Expanded(child: SizedBox()), // This expands the space between text and arrow icon
              Icon(Icons.arrow_back_ios_new, color: habitCompleted ? Colors.white : Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
