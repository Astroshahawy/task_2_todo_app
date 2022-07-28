part of 'tasks_cubit.dart';

abstract class TasksState {}

class TasksInitialState extends TasksState {}

class TasksLoaded extends TasksState {}

class TasksErrorState extends TasksState {
  String? error;
  TasksErrorState({
    required this.error,
  });
}

class TaskDateChanged extends TasksState {}

class TaskStartTimeChanged extends TasksState {}

class TaskEndTimeChanged extends TasksState {}

class TaskColorChanged extends TasksState {}

class ScheduleDateChanged extends TasksState {}
