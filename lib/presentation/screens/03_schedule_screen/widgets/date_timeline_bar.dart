import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:task_2_todo_app/constants/constants.dart';
import 'package:task_2_todo_app/presentation/cubit/tasks_cubit.dart';

class DateTimelineBar extends StatelessWidget {
  const DateTimelineBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          child: DatePicker(
            DateTime.now(),
            height: 85,
            selectedTextColor: Colors.white,
            selectionColor: kButtonColor,
            initialSelectedDate: DateTime.now(),
            dayTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            dateTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            onDateChange: (selectedDate) {
              TasksBloc.get(context).datePickerSelectedDate = selectedDate;
              TasksBloc.get(context).changeScheduleDate();
            },
          ),
        ),
        const Divider(
          thickness: 2.5,
          height: 0.0,
        ),
      ],
    );
  }
}
