import 'package:flutter/material.dart';

import 'tab_bar_pages_widgets/all_tasks_page.dart';
import 'tab_bar_pages_widgets/completed_tasks_page.dart';
import 'tab_bar_pages_widgets/favorite_tasks_page.dart';
import 'tab_bar_pages_widgets/uncompleted_tasks_page.dart';

class TabBarPages extends StatelessWidget {
  const TabBarPages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        physics: BouncingScrollPhysics(),
        children: [
          AllTasksPage(),
          CompletedTasksPage(),
          UncompletedTasksPage(),
          FavoriteTasksPage(),
        ],
      ),
    );
  }
}
