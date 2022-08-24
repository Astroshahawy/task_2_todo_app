import 'package:flutter/material.dart';
import '../../../cubit/tasks_cubit.dart';
import '../../../../constants/constants.dart';
import 'field_section.dart';

class TaskTitleSection extends StatelessWidget {
  const TaskTitleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      title: 'Title',
      child: TextFormField(
        controller: TasksBloc.get(context).taskTitleController,
        style: TextStyle(
          color: Colors.grey.shade400,
        ),
        cursorColor: AppColors.kButtonColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a task title..',
          hintStyle: TextStyle(
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
