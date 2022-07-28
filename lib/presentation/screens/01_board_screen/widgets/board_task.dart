import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../../data/models/task.dart';
import '../../../widgets/task_options_button.dart';

class BoardTask extends StatelessWidget {
  final Task task;

  const BoardTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => taskOptionsModalSheet(context: context, task: task),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color:
                    task.isCompleted ? Color(task.color) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(task.color),
                  width: 2.5,
                ),
              ),
              alignment: Alignment.center,
              child: task.isCompleted
                  ? const MacosIcon(
                      CupertinoIcons.checkmark_alt,
                      size: 18,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            Flexible(
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(width: 20),
            if (task.isFavorite)
              const MacosIcon(
                CupertinoIcons.star_fill,
                size: 14,
                color: Colors.amber,
              ),
          ],
        ),
      ),
    );
  }
}
