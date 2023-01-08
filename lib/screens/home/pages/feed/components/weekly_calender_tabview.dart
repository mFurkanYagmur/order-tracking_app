import 'package:flutter/material.dart';

import 'weekly_calender_item.dart';

class WeeklyCalender extends StatefulWidget {
  const WeeklyCalender({Key? key, required this.indexDay, required this.onDayChanged}) : super(key: key);

  final DateTime indexDay;
  final Function(int index) onDayChanged;

  @override
  _WeeklyCalenderState createState() => _WeeklyCalenderState();
}

class _WeeklyCalenderState extends State<WeeklyCalender> {
  late int selectedIndex;
  late DateTime selectedDate;
  late DateTime firstDate;

  final List<String> dayWordList = [
    'Pzt',
    'Sal',
    'Çar',
    'Per',
    'Cum',
    'Cts',
    'Paz',
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = widget.indexDay;
    firstDate = widget.indexDay.subtract(Duration(days: widget.indexDay.weekday-1));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<DateTime> dateList = List.generate(7, (index) => firstDate.add(Duration(days: index)));

    return dateList.map((e) {
      return Expanded(
        child: GestureDetector(
            onTap: () {
              setState(() {
                  selectedDate = e;
                });
              widget.onDayChanged(dateList.indexOf(e));
            },
            child: WeeklyCalendarItem(isSelected: selectedDate.day == e.day, dayOfMonth: e.day, dayWord: dayWordList[(e.weekday-1) % 7],)),
      );
    }).toList();
  }
}
