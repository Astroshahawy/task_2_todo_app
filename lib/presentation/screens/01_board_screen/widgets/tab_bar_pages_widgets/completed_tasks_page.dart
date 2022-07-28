import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/tasks_cubit.dart';
import '../board_task.dart';

class CompletedTasksPage extends StatelessWidget {
  const CompletedTasksPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(40, 15, 40, 35),
          itemCount: TasksBloc.get(context).completedTasks.length,
          itemBuilder: (context, index) {
            return BoardTask(
              task: TasksBloc.get(context).completedTasks[index],
            );
          },
        );
      },
    );
  }
}
