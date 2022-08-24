import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_todo_app/presentation/widgets/no_tasks_text.dart';
import 'package:task_2_todo_app/presentation/widgets/task_slide_fade_animation.dart';
import '../../../../cubit/tasks_cubit.dart';
import '../board_task.dart';

class AllTasksPage extends StatelessWidget {
  const AllTasksPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TasksBloc.get(context).fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return TasksBloc.get(context).allTasks.isEmpty
                  ? const NoTaskText(text: 'No tasks yet..')
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 35),
                      itemCount: TasksBloc.get(context).allTasks.length,
                      itemBuilder: (context, index) {
                        return TaskSlideFadeAnimation(
                          index: index,
                          child: BoardTask(
                            task: TasksBloc.get(context).allTasks[index],
                          ),
                        );
                      },
                    );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
