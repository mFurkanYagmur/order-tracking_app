import 'package:flutter/material.dart';

import '../../../../../constants/style.dart';

class WeeklyCalendarItem extends StatefulWidget {
  WeeklyCalendarItem({
    Key? key,
    required this.isSelected,
    required this.dayOfMonth,
    required this.dayWord,
  }) : super(key: key);

  bool isSelected;
  int dayOfMonth;
  String dayWord;

  @override
  State<WeeklyCalendarItem> createState() => _WeeklyCalendarItemState();
}

class _WeeklyCalendarItemState extends State<WeeklyCalendarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Style.defaultPadding * 0.75,
        horizontal: Style.defaultPadding * 0.1,
      ),
      margin: EdgeInsets.symmetric(vertical: Style.defaultPadding/2),
      decoration: _boxDecoration(widget.isSelected),
      child: Column(
        children: [
          Text(
            '${widget.dayOfMonth}',
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: widget.isSelected ? Colors.white : Theme.of(context).hintColor,
                ),
          ),
          SizedBox(
            height: Style.defaultPadding * 0.5,
          ),
          Text(
            widget.dayWord,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: widget.isSelected ? Colors.white : Theme.of(context).hintColor,
                ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(bool isSelected) {
    return BoxDecoration(
        color: isSelected ? null : Colors.transparent,
        gradient: isSelected ? Style.secondaryGradient : null,
        borderRadius: BorderRadius.circular(100),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Style.secondaryColor.withOpacity(0.4),
                  blurRadius: Style.defaultRadiusSize,
                  spreadRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]
            : [
                BoxShadow(color: Colors.transparent, blurRadius: Style.defaultRadiusSize),
              ]);
  }
}
