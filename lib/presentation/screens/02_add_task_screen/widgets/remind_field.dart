import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../cubit/tasks_cubit.dart';
import 'field_section.dart';

class RemindField extends StatelessWidget {
  const RemindField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      title: 'Remind',
      isSmallMarginRight: true,
      child: DropdownButtonFormField(
        onChanged: (String? value) {
          TasksBloc.get(context).remindValue = value!;
          TasksBloc.get(context).changeRemindValue();
        },
        elevation: 4,
        dropdownColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(
          'No remind',
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
        icon: Icon(
          CupertinoIcons.chevron_down,
          color: Colors.grey.shade400,
        ),
        items: [
          DropdownMenuItem(
            child: Text(
              'No remind',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            value: '0',
          ),
          DropdownMenuItem(
            child: Text(
              '5 minutes early',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            value: '5',
          ),
          DropdownMenuItem(
            child: Text(
              '10 minutes early',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            value: '10',
          ),
          DropdownMenuItem(
            child: Text(
              '15 minutes early',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            value: '15',
          ),
          DropdownMenuItem(
            child: Text(
              '20 minutes early',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            value: '20',
          ),
          DropdownMenuItem(
            child: Text(
              '30 minutes early',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            value: '30',
          ),
        ],
      ),
    );
  }
}
