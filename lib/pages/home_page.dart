import 'package:flutter/material.dart';
import 'package:habit_tracker_hive/components/monthly_summary.dart';
import 'package:habit_tracker_hive/data/habit_database.dart';
import 'package:hive/hive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/my_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum SortOptions { notCompleted, aToZ }

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get('CURRENT_HABIT_LIST') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  void sortList(SortOptions option) {
    setState(() {
      if (option == SortOptions.notCompleted) {
        db.todaysHabitList.sort((a, b) => a[1].toString().compareTo(b[1].toString()));
      } else if (option == SortOptions.aToZ) {
        db.todaysHabitList.sort((a, b) => a[0].compareTo(b[0]));
      }
    });
  }


  bool habitCompleted = false;

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitNameController,
            hintText: 'Enter habit name..',
            onCancel: cancelDialogBox,
            onSave: saveNewHabit,
          );
        });
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettigs(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
            controller: _newHabitNameController,
            hintText: db.todaysHabitList[index][0],
            onCancel: cancelDialogBox,
            onSave: () => saveExistingHabit(index));
      },
    );
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: () {
          createNewHabit();
        },
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(  
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18.0, bottom: 10.0),
              child: Text("HabitScribe", style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 30.0))),
            ),
            MonthlySummary(
                datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")),
            const Divider(
              height: 30,
              color: Colors.black45,
              thickness: 2,
              indent: 60,
              endIndent: 60, ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Day", style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 18.0))),
                  PopupMenuButton<SortOptions>(
                    iconSize: 32.0,
                    icon: Icon(Icons.sort),
                    onSelected: sortList,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOptions>>[
                      PopupMenuItem<SortOptions>(
                        value: SortOptions.notCompleted,
                        child: Text("Not Completed", style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 16.0))),
                      ),
                      PopupMenuItem<SortOptions>(
                        value: SortOptions.aToZ,
                        child: Text("A to Z", style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 16.0))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: db.todaysHabitList.length,
                  itemBuilder: (context, index) {
                    return HabitTile(
                      habitName: db.todaysHabitList[index][0],
                      habitCompleted: db.todaysHabitList[index][1],
                      onChanged: (value) => checkBoxTapped(value, index),
                      settingsTapped: (context) => openHabitSettigs(index),
                      deleteTapped: (context) => deleteHabit(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
