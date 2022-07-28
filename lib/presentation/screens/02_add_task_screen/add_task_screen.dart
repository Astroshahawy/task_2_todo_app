import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../cubit/tasks_cubit.dart';
import 'widgets/color_field.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/remind_field.dart';
import 'widgets/task_title_field.dart';
import 'widgets/time_picker_field.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_long_button.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const CustomAppBar(screenTitle: 'Add task'),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const TaskTitleSection(),
                        const DatePickerField(),
                        const TimePickerField(),
                        Row(
                          children: const [
                            Flexible(
                              flex: 5,
                              child: RemindField(),
                            ),
                            Flexible(
                              flex: 2,
                              child: ColorField(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: BlocListener<TasksBloc, TasksState>(
                listener: (context, state) {
                  if (state is TasksErrorState) {
                    showMacosAlertDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.3),
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Warning!',
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
                            state.error!,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 100,
                          ),
                        );
                      },
                    );
                  }
                },
                child: CustomLongButton(
                  title: 'Create a task',
                  onPressed: () {
                    TasksBloc.get(context).validateTask(context: context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
