import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/common/widgets/filled_field.dart';
import 'package:todo_riverpod/core/common/widgets/round_button.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/features/todo/app/task_date_provider.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            const WhiteSpace(
              height: 20,
            ),
            FilledField(
              controller: titleController,
              hintText: 'Add Title',
            ),
            const WhiteSpace(
              height: 20,
            ),
            FilledField(
              controller: descriptionController,
              hintText: 'Add Description',
            ),
            const WhiteSpace(
              height: 20,
            ),
            RoundButton(
              text: 'Date',
              backgroundColour: Colors.grey[500],
              textColour: ColorsRes.light,
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  minTime: DateTime.now(),
                  maxTime: DateTime(DateTime.now().year + 1),
                  onConfirm: (date) {
                    ref.read(taskDateProvider.notifier).changeDate(date);
                  },
                );
              },
            ),
            const WhiteSpace(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    text: 'Start Time',
                    backgroundColour: Colors.grey[600],
                    textColour: ColorsRes.light,
                    onPressed: () {},
                  ),
                ),
                const WhiteSpace(
                  width: 20,
                ),
                Expanded(
                  child: RoundButton(
                    text: 'End Time',
                    backgroundColour: Colors.grey[500],
                    textColour: ColorsRes.light,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const WhiteSpace(
              height: 20,
            ),
            RoundButton(
              text: 'Submit',
              backgroundColour: Colors.green,
              textColour: ColorsRes.light,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
