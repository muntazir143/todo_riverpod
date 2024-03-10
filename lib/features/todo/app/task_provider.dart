import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/core/helper/db_helper.dart';
import 'package:todo_riverpod/features/todo/models/task_model.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTasks();
    state = data.map((taskData) {
      return TaskModel.fromMap(taskData);
    }).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> deleteTask(int taskId) async {
    await DBHelper.deleteTask(taskId);
    refresh();
  }

  Future<List<TaskModel>> getTasksForToday() async {
    final today = DateTime.now();
    if (state.isEmpty) return state;
    return state
        .where((task) => DateUtils.isSameDay(task.date, today))
        .toList();
  }

  Future<List<TaskModel>> getTasksForTomorrow() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    if (state.isEmpty) return state;
    return state
        .where((task) => DateUtils.isSameDay(task.date, tomorrow))
        .toList();
  }

  Future<List<TaskModel>> getTasksForDayAfterTomorrow() async {
    final dayAfterTomorrow = DateTime.now().add(const Duration(days: 2));
    if (state.isEmpty) return state;
    return state
        .where((task) => DateUtils.isSameDay(task.date, dayAfterTomorrow))
        .toList();
  }

  Future<List<TaskModel>> getTasksFromOneMonthAgo() async {
    final oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
    if (state.isEmpty) return state;
    return state
        .where((task) =>
            task.date!.isAfter(oneMonthAgo) &&
            task.date!.isBefore(DateUtils.dateOnly(DateTime.now())))
        .toList();
  }

  Future<List<TaskModel>> getCompletedTasksForToday() async {
    if (state.isEmpty) return state;
    final tasksForToday = await getTasksForToday();
    return tasksForToday.where((task) => task.isCompleted).toList();
  }

  Future<List<TaskModel>> getPendingTasksForToday() async {
    if (state.isEmpty) return state;
    final tasksForToday = await getTasksForToday();
    return tasksForToday.where((task) => !task.isCompleted).toList();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }
}
