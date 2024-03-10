import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/features/todo/app/task_provider.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';

class PendingTasks extends ConsumerWidget {
  const PendingTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(taskProvider.notifier).getPendingTasksForToday(),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Pending Tasks',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: ColorsRes.light.withOpacity(.6),
                  fontSize: 18,
                ),
              ),
            );
          }
          return ColoredBox(
            color: Colors.grey[400]!,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final task = snapshot.data![index];
                return TodoTile(task: task);
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
