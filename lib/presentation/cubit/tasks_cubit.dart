import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:task_2_todo_app/constants/constants.dart';
import 'package:task_2_todo_app/data/services/notification_services.dart';
import '../../data/models/task.dart';

part 'tasks_state.dart';

class TasksBloc extends Cubit<TasksState> {
  TasksBloc() : super(TasksInitialState());

  static TasksBloc get(context) => BlocProvider.of<TasksBloc>(context);
  //
  //     ===========================================================================
  //     ===========================================================================
  //     ||                                                                       ||
  //     ||     -------------------------------------------------------------     ||
  //     ||                                                                       ||
  //     ||     WARNING: SPAGHETTI CODE BELOW THERE - REFACTORING IN PROGRESS     ||
  //     ||                                                                       ||
  //     ||     -------------------------------------------------------------     ||
  //     ||                                                                       ||
  //     ===========================================================================
  //     ===========================================================================
  //
  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'tasks.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, color INTEGER, remind INTEGER, isCompleted INTEGER, isFavorite INTEGER)',
        );
      },
    );
  }

  TextEditingController taskTitleController = TextEditingController();
  final DateTime dateTimeNow = DateTime.now();
  DateTime? selectedDate = DateTime.now();
  late String formattedDate = DateFormat('dd-MM-yyyy').format(dateTimeNow);
  TimeOfDay? selectedStartTime = TimeOfDay.now();
  late String formattedStartTime = DateFormat.jm().format(dateTimeNow);
  late String comparableStartTime = convertToHm(dateTime: dateTimeNow);
  late TimeOfDay? selectedEndTime = TimeOfDay.fromDateTime(
    dateTimeNow.add(
      const Duration(minutes: 1),
    ),
  );
  late String formattedEndTime = DateFormat.jm().format(
    dateTimeNow.add(
      const Duration(minutes: 1),
    ),
  );
  late String comparableEndTime = convertToHm(
    dateTime: dateTimeNow.add(
      const Duration(minutes: 1),
    ),
  );
  Color selectedTaskColor = Colors.red;
  late int taskColor = selectedTaskColor.value;
  String? selectedRemindValue;
  late int remindValue = 0;

  void changeDate() {
    if (selectedDate != null) {
      formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate!);
      emit(TaskDateChanged());
      return;
    }
    selectedDate ??= DateTime.parse(formattedDate.split('-').reversed.join(''));
  }

  void changeStartTime() {
    if (selectedStartTime != null) {
      formattedStartTime = DateFormat.jm().format(
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day,
            selectedStartTime!.hour, selectedStartTime!.minute),
      );
      comparableStartTime = convertToHm(
        dateTime: DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day,
            selectedStartTime!.hour, selectedStartTime!.minute),
      );
      emit(TaskStartTimeChanged());
      return;
    }
    selectedStartTime ??= TimeOfDay.fromDateTime(dateTimeNow);
  }

  void changeEndTime() {
    if (selectedEndTime != null) {
      formattedEndTime = DateFormat.jm().format(
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day,
            selectedEndTime!.hour, selectedEndTime!.minute),
      );
      comparableEndTime = convertToHm(
        dateTime: DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day,
            selectedEndTime!.hour, selectedEndTime!.minute),
      );
      emit(TaskEndTimeChanged());
      return;
    }
    selectedEndTime ??= TimeOfDay.fromDateTime(
      dateTimeNow.add(
        const Duration(minutes: 1),
      ),
    );
  }

  void changeColor() {
    taskColor = selectedTaskColor.value;
    emit(TaskColorChanged());
  }

  void changeRemindValue() {
    remindValue = int.tryParse(selectedRemindValue!) ?? 0;
  }

  void validateTask({required BuildContext context}) {
    if (taskTitleController.text.isEmpty ||
        taskTitleController.text.trim() == '') {
      emit(TasksErrorState(error: 'Please enter a task title'));
      return;
    } else if (comparableStartTime.compareTo(comparableEndTime) > 0 ||
        comparableStartTime == comparableEndTime) {
      emit(TasksErrorState(error: 'Please check start time and end time'));
      return;
    }
    insertTask();
    Navigator.pop(context);
  }

  late NotificationServices _notificationServices;
  Future<void> insertTask() async {
    final Database database = await initDatabase();
    Task _task = Task(
      title: taskTitleController.text.trim(),
      date: formattedDate,
      startTime: formattedStartTime,
      endTime: formattedEndTime,
      color: taskColor,
      remind: remindValue,
      isCompleted: false,
      isFavorite: false,
    );
    await database.insert(
      'tasks',
      _task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    taskTitleController.clear();
    _notificationServices = NotificationServices();
    _notificationServices.scheduleNotification(
      task: _task,
      taskDate: selectedDate!,
      taskTime: selectedStartTime!,
    );
  }

  List<Task> allTasks = [];
  Future<void> fetchTasks() async {
    final Database database = await initDatabase();
    final List<Map<String, dynamic>> _allTasks = await database.query('tasks');
    allTasks = _allTasks.map((task) => Task.fromMap(task)).toList();
    emit(TasksLoaded());
  }

  void completeTask(Task task) async {
    final Database database = await initDatabase();
    task.isCompleted = !task.isCompleted;
    await database.update(
      'tasks',
      {'isCompleted': task.isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchAllData();
  }

  void favoriteTask(Task task) async {
    final Database database = await initDatabase();
    task.isFavorite = !task.isFavorite;
    await database.update(
      'tasks',
      {'isFavorite': task.isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchAllData();
  }

  void deleteTask(Task task) async {
    final Database database = await initDatabase();
    await database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
    fetchAllData();
  }

  List<Task> completedTasks = [];
  void fetchCompletedTasks() {
    completedTasks = allTasks.where((task) => task.isCompleted).toList();
    emit(TasksLoaded());
  }

  List<Task> uncompletedTasks = [];
  void fetchUncompletedTasks() {
    uncompletedTasks = allTasks.where((task) => !task.isCompleted).toList();
    emit(TasksLoaded());
  }

  List<Task> favoriteTasks = [];
  void fetchFavoriteTasks() {
    favoriteTasks = allTasks.where((task) => task.isFavorite).toList();
    emit(TasksLoaded());
  }

  void onPageChanged(TabController? tabController) {
    int currentTab = 0;
    currentTab = tabController!.index;
    switch (currentTab) {
      case 0:
        fetchTasks();
        break;
      case 1:
        fetchCompletedTasks();
        break;
      case 2:
        fetchUncompletedTasks();
        break;
      case 3:
        fetchFavoriteTasks();
        break;
    }
  }

  void fetchAllData() async {
    await fetchTasks();
    fetchCompletedTasks();
    fetchUncompletedTasks();
    fetchFavoriteTasks();
  }

  DateTime datePickerSelectedDate = DateTime.now();
  late String scheduleDayName = DateFormat('EEEE').format(dateTimeNow);
  late String scheduleFormattedDate =
      DateFormat('dd MMM,yyyy').format(dateTimeNow);

  void changeScheduleDate() {
    scheduleDayName = DateFormat('EEEE').format(
      datePickerSelectedDate,
    );
    scheduleFormattedDate = DateFormat('dd MMM,yyyy').format(
      datePickerSelectedDate,
    );
    emit(ScheduleDateChanged());
  }

  DateTime convertJmToDateTime(String jmDate) {
    return DateTime(
      dateTimeNow.year,
      dateTimeNow.month,
      dateTimeNow.day,
      TimeOfDay(
        // ADD 12 TO HOUR BECAUSE IF JM FORMAT CONTAINS PM
        hour: jmDate.contains('P', 5)
            ? 12
            : 0 + int.parse(jmDate.substring(0, 5).split(':')[0]),
        minute: int.parse(jmDate.substring(0, 5).split(':')[1]),
      ).hour,
      TimeOfDay(
        // ADD 12 TO HOUR BECAUSE IF JM FORMAT CONTAINS PM
        hour: jmDate.contains('P', 5)
            ? 12
            : 0 + int.parse(jmDate.substring(0, 5).split(':')[0]),
        minute: int.parse(jmDate.substring(0, 5).split(':')[1]),
      ).minute,
    );
  }

  String convertToHm({DateTime? dateTime, String? jmDate}) {
    return DateFormat.Hm()
        .format(dateTime ?? convertJmToDateTime(jmDate!))
        .split(':')
        .join();
  }

  List<Task> sortTasks(List<Task> tasks) {
    tasks.sort((a, b) {
      if (a.date.split('-').reversed.join('') ==
          b.date.split('-').reversed.join('')) {
        return convertToHm(jmDate: a.startTime)
            .compareTo(convertToHm(jmDate: b.startTime));
      }
      return a.date
          .split('-')
          .reversed
          .join('')
          .compareTo(b.date.split('-').reversed.join(''));
    });
    return tasks;
  }

  List<Task> fetchScheduleTasksByDate() {
    return sortTasks(allTasks)
        .where((task) =>
            task.date ==
            DateFormat('dd-MM-yyyy').format(datePickerSelectedDate))
        .toList();
  }

  void listenNotifications(BuildContext context) async {
    late NotificationServices notificationServices = NotificationServices();
    await notificationServices.initializeNotification();
    notificationServices.onNotifications.stream.listen(
      (payload) async {
        await Navigator.pushNamed(context, AppRoutes.scheduleScreen);
        fetchAllData();
      },
    );
  }

  // void deleteAllData() async {
  //   final Database database = await initDatabase();
  //   database.delete('tasks').then(
  //     (value) {
  //       debugPrint('db deleted');
  //       emit(TasksLoaded());
  //     },
  //   );
  //   await fetchTasks();
  // }
}
