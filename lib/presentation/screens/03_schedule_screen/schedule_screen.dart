import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_2_todo_app/presentation/cubit/tasks_cubit.dart';
import 'package:task_2_todo_app/presentation/screens/03_schedule_screen/widgets/date_display_row.dart';
import 'package:task_2_todo_app/presentation/screens/03_schedule_screen/widgets/date_timeline_bar.dart';
import 'package:task_2_todo_app/presentation/screens/03_schedule_screen/widgets/schedule_task.dart';
import 'package:task_2_todo_app/presentation/widgets/task_slide_fade_animation.dart';

import '../../widgets/custom_app_bar.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(screenTitle: 'Schedule'),
          const DateTimelineBar(),
          const DateDisplayRow(),
          Expanded(
            child: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 40),
                  itemCount: TasksBloc.get(context)
                      .fetchScheduleTasksByDate(TasksBloc.get(context).allTasks)
                      .length,
                  itemBuilder: (context, index) {
                    return TaskSlideFadeAnimation(
                      index: index,
                      horizontalOffset: 80,
                      animationDuration: 500,
                      child: ScheduleTask(
                        task: TasksBloc.get(context).fetchScheduleTasksByDate(
                            TasksBloc.get(context).allTasks)[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
