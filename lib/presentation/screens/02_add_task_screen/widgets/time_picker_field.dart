import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../cubit/tasks_cubit.dart';

import 'field_section.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              TasksBloc.get(context).selectedStartTime = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 00, minute: 00),
              );
              TasksBloc.get(context).changeStartTime();
            },
            child: FieldSection(
              title: 'Start time',
              isSmallMarginRight: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) {
                      return Text(
                        TasksBloc.get(context).formattedStartTime,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                  MacosIcon(
                    CupertinoIcons.time,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              TasksBloc.get(context).selectedEndTime = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 00, minute: 00),
              );
              TasksBloc.get(context).changeEndTime();
            },
            child: FieldSection(
              title: 'End time',
              isSmallMarginLeft: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) {
                      return Text(
                        TasksBloc.get(context).formattedEndTime,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                  MacosIcon(
                    CupertinoIcons.time,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
