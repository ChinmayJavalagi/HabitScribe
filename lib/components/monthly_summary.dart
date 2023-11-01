import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_hive/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    required this.datasets,
    required this.startDate,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.grey[500],
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color(0xffa9d6e5),
          2: Color(0xff89c2d9),
          3: Color(0xff61a5c2),
          4: Color(0xff468faf),
          5: Color(0xff2c7da0),
          6: Color(0xff2a6f97),
          7: Color(0xff014f86),
          8: Color(0xff01497c),
          9: Color(0xff013a63),
          10: Color(0xff012a4a),
        },
      ),
    );
  }
}
