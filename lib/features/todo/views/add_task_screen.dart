import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/common/widgets/filled_field.dart';
import 'package:todo_riverpod/core/common/widgets/round_button.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/core/utils/core_utils.dart';
import 'package:todo_riverpod/features/todo/app/task_date_provider.dart';
import 'package:todo_riverpod/features/todo/app/task_provider.dart';
import 'package:todo_riverpod/features/todo/models/task_model.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final dateProvider = ref.watch(taskDateProvider);
    final startTimeProvider = ref.watch(taskStartTimeProvider);
    final endTimeProvider = ref.watch(taskEndTimeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorsRes.light,
      ),
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
              text: ref.watch(taskDateProvider) == null
                  ? 'Set Date'
                  : ref.read(taskDateProvider.notifier).date()!,
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
                    text: ref.watch(taskStartTimeProvider) == null
                        ? 'Start Time'
                        : ref.read(taskStartTimeProvider.notifier).time()!,
                    backgroundColour: Colors.grey[600],
                    textColour: ColorsRes.light,
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                            context: context,
                            message: 'Please pick a date first');
                        return;
                      }
                      DatePicker.showDateTimePicker(context, onConfirm: (time) {
                        ref
                            .read(taskStartTimeProvider.notifier)
                            .changeTime(time);
                      });
                    },
                  ),
                ),
                const WhiteSpace(
                  width: 20,
                ),
                Expanded(
                  child: RoundButton(
                    text: ref.watch(taskEndTimeProvider) == null
                        ? 'End Time'
                        : ref.read(taskEndTimeProvider.notifier).time()!,
                    backgroundColour: Colors.grey[500],
                    textColour: ColorsRes.light,
                    onPressed: () {
                      if (startTimeProvider == null) {
                        CoreUtils.showSnackBar(
                            context: context,
                            message: 'Please pick a start time first');
                        return;
                      }
                      DatePicker.showDateTimePicker(context, onConfirm: (time) {
                        ref.read(taskEndTimeProvider.notifier).changeTime(time);
                      });
                    },
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
              onPressed: () async {
                if (titleController.text.trim().isNotEmpty &&
                    descriptionController.text.trim().isNotEmpty &&
                    dateProvider != null &&
                    startTimeProvider != null &&
                    endTimeProvider != null) {
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  await ref.read(taskProvider.notifier).addTask(TaskModel(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        date: dateProvider,
                        startTime: startTimeProvider,
                        endTime: endTimeProvider,
                        remind: false,
                        repeat: true,
                      ));
                  navigator
                    ..pop()
                    ..pop();
                } else {
                  CoreUtils.showSnackBar(
                      context: context, message: 'All fields are required');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
