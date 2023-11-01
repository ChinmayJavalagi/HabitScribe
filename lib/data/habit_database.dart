import 'package:habit_tracker_hive/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List todaysHabitList = [];
  void createDefaultData(){
    todaysHabitList = [
      ["Run", false],
      ["Read", false],
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }
  void loadData(){
    if (_myBox.get(todaysDateFormatted()) == null){
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for(int i = 0;i<todaysHabitList.length;i++){
        todaysHabitList[i][1] = false;
      }
    }else{
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }
  void updateDatabase(){
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
  }
}