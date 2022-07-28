import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../../constants/constants.dart';
import '../../../cubit/tasks_cubit.dart';
import 'field_section.dart';

class ColorField extends StatelessWidget {
  const ColorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      isSmallMarginLeft: true,
      title: 'Color',
      child: GestureDetector(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
              actionsPadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Pick a color!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              content: BlockPicker(
                availableColors: pickerColors,
                pickerColor: TasksBloc.get(context).selectedColor,
                onColorChanged: (Color color) {
                  Navigator.of(context).pop();
                  TasksBloc.get(context).selectedColor = color;
                },
              ),
            ),
          );
          TasksBloc.get(context).changeColor();
        },
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: TasksBloc.get(context).selectedColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
