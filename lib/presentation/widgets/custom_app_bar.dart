import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:task_2_todo_app/presentation/cubit/tasks_cubit.dart';

import '../../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.isHomeScreen = false,
    required this.screenTitle,
  }) : super(key: key);

  final bool isHomeScreen;
  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).viewPadding.top + 20,
          width: double.infinity,
        ),
        SizedBox(
          height: 90,
          width: double.infinity,
          child: Row(
            children: [
              if (!isHomeScreen)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 30),
                    child: const MacosIcon(
                      CupertinoIcons.back,
                      color: Colors.black,
                    ),
                  ),
                ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isHomeScreen ? 40 : 0),
                child: Text(
                  screenTitle,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              if (isHomeScreen) const ActionsRow(),
            ],
          ),
        ),
        const Divider(
          thickness: 2.5,
          height: 0.0,
        ),
      ],
    );
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: MacosIcon(
              CupertinoIcons.search,
              color: Colors.grey[700],
              size: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
            child: MacosIcon(
              CupertinoIcons.bell,
              color: Colors.grey[700],
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed(scheduleScreen);
              TasksBloc.get(context).fetchAllData();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(15, 20, 35, 20),
              child: MacosIcon(
                CupertinoIcons.calendar,
                color: Colors.grey[700],
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
