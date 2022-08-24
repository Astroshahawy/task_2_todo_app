import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_todo_app/constants/constants.dart';
import '../cubit/tasks_cubit.dart';
import '../screens/01_board_screen/board_screen.dart';
import '../screens/02_add_task_screen/add_task_screen.dart';
import '../screens/03_schedule_screen/schedule_screen.dart';

class AppRouter {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider<TasksBloc>(
            create: (context) => TasksBloc()..fetchAllData(),
            child: const BoardScreen(),
          ),
        );
      case AppRoutes.addTaskScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider<TasksBloc>(
            create: (context) => TasksBloc(),
            child: const AddTaskScreen(),
          ),
        );
      case AppRoutes.scheduleScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => TasksBloc()..fetchAllData(),
            child: const ScheduleScreen(),
          ),
        );
    }
  }
}
