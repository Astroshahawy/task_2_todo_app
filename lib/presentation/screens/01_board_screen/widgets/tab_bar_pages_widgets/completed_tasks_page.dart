import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_todo_app/presentation/screens/01_board_screen/widgets/tab_bar_pages_widgets/page_content.dart';
import '../../../../cubit/tasks_cubit.dart';

class CompletedTasksPage extends StatelessWidget {
  const CompletedTasksPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return PageContent(
          tasksList: TasksBloc.get(context).completedTasks,
          noTasksText: 'No completed tasks yet..',
        );
      },
    );
  }
}
