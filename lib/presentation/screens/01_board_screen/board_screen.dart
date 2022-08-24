import 'package:flutter/material.dart';
import 'package:task_2_todo_app/constants/constants.dart';
import '../../cubit/tasks_cubit.dart';
import 'widgets/tab_bar_pages_view.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_long_button.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  void initState() {
    super.initState();
    TasksBloc.get(context).listenNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: const [
              CustomAppBar(
                screenTitle: 'Board',
                isHomeScreen: true,
              ),
              TabBarPagesView(),
              SizedBox(height: 80),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 40,
            right: 40,
            child: CustomLongButton(
              title: 'Add a task',
              onPressed: () async {
                await Navigator.of(context).pushNamed(AppRoutes.addTaskScreen);
                TasksBloc.get(context).fetchAllData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
