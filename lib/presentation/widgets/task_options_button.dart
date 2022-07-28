import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:task_2_todo_app/data/models/task.dart';
import 'package:task_2_todo_app/presentation/cubit/tasks_cubit.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Future<dynamic> taskOptionsModalSheet(
    {required BuildContext context, required Task task}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    barrierColor: Colors.black.withOpacity(0.65),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(40),
        height: MediaQuery.of(context).size.height * 0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OptionButton(
              label: !task.isCompleted
                  ? 'Mark as completed'
                  : 'Mark as uncompleted',
              color: !task.isCompleted ? Colors.green : Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                TasksBloc.get(context).completeTask(task);
              },
            ),
            OptionButton(
              label: !task.isFavorite
                  ? 'Add to favorites'
                  : 'Remove from favorites',
              color: !task.isFavorite ? Colors.amber : Colors.teal,
              onPressed: () {
                Navigator.pop(context);
                TasksBloc.get(context).favoriteTask(task);
              },
            ),
            OptionButton(
              label: 'Delete',
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
                showMacosAlertDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.65),
                  builder: (_) {
                    return AlertDialog(
                      title: const Text(
                        'Delete task',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 0.5,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      content: Text(
                        'Are you sure you want to delete this task?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('NO'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text('YES'),
                          onPressed: () {
                            TasksBloc.get(context).deleteTask(task);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      insetPadding: const EdgeInsets.symmetric(
                        horizontal: 80,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
