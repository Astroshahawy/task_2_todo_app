import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../cubit/tasks_cubit.dart';
import '../../../../constants/constants.dart';
import 'field_section.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TasksBloc.get(context).selectedDate = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: TasksBloc.get(context).selectedDate!,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: kButtonColor,
                  onSurface: kButtonColor,
                ),
              ),
              child: child!,
            );
          },
        );
        TasksBloc.get(context).changeDate();
      },
      child: FieldSection(
        title: 'Date',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return Text(
                  TasksBloc.get(context).formattedDate,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
            MacosIcon(
              CupertinoIcons.calendar_today,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
