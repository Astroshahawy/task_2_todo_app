import 'package:flutter/material.dart';
import 'tab_bar_pages.dart';
import 'tab_bar_tab.dart';

class TabBarPagesView extends StatelessWidget {
  const TabBarPagesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 3.5,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.grey.shade400,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              tabs: const [
                TabBarTab(label: 'All'),
                TabBarTab(label: 'Completed'),
                TabBarTab(label: 'Uncompleted'),
                TabBarTab(label: 'Favorite'),
              ],
            ),
            const Divider(
              thickness: 2.5,
              height: 0.0,
            ),
            const TabBarPages(),
          ],
        ),
      ),
    );
  }
}
