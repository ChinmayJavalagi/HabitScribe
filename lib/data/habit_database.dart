import 'package:habit_tracker_hive/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};
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

    calculateHabitPercentages();

    loadHeatMap();
  }

  void calculateHabitPercentages(){
    int countCompleted = 0;
    for(int i = 0; i<todaysHabitList.length;i++){
      if(todaysHabitList[i][1] == true){
        countCompleted++;
      }
    }
    String percent = todaysHabitList.isEmpty? '0.0':(countCompleted/todaysHabitList.length).toStringAsFixed(1);
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap(){
   DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

   int daysInBetween = DateTime.now().difference(startDate).inDays;

   for (int i=0;i<daysInBetween+1;i++){
     String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i)),
     );

     double strength = double.parse(
       _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ??"0.0",
     );

     int year = startDate.add(Duration(days:i)).year;
     int month = startDate.add(Duration(days:i)).month;
     int day = startDate.add(Duration(days:i)).day;

     final percentForEachDay = <DateTime,int>{
       DateTime(year, month, day): (10*strength).toInt(),
     };
     heatMapDataSet.addEntries(percentForEachDay.entries);
   }
  }
}