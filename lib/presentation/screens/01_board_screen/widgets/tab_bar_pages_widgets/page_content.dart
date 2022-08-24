import 'package:flutter/material.dart';

import 'package:task_2_todo_app/data/models/task.dart';
import 'package:task_2_todo_app/presentation/screens/01_board_screen/widgets/board_task.dart';
import 'package:task_2_todo_app/presentation/widgets/no_tasks_text.dart';

class PageContent extends StatelessWidget {
  final List<Task> tasksList;
  final String noTasksText;
  const PageContent({
    Key? key,
    required this.tasksList,
    required this.noTasksText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasksList.isEmpty
        ? NoTaskText(text: noTasksText)
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 35),
            itemCount: tasksList.length,
            itemBuilder: (context, index) {
              return BoardTask(
                task: tasksList[index],
              );
            },
          );
  }
}
