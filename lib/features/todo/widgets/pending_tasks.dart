import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/todo/app/task_provider.dart';

class PendingTasks extends ConsumerWidget {
  const PendingTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(taskProvider.notifier).getPendingTasksForToday(),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {},
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
