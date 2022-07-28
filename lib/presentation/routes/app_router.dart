import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tasks_cubit.dart';
import '../../constants/constants.dart';
import '../screens/01_board_screen/board_screen.dart';
import '../screens/02_add_task_screen/add_task_screen.dart';
import '../screens/03_schedule_screen/schedule_screen.dart';

class AppRouter {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider<TasksBloc>(
            create: (context) => TasksBloc()..fetchAllData(),
            child: const BoardScreen(),
          ),
        );
      case addTaskScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider<TasksBloc>(
            create: (context) => TasksBloc(),
            child: const AddTaskScreen(),
          ),
        );
      case scheduleScreen:
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
