import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_date_provider.g.dart';

@riverpod
class TaskDate extends _$TaskDate {
  @override
  DateTime? build() => null;

  void changeDate(DateTime date) {
    state = date;
  }

  void reset() => state = null;
}

@riverpod
class TaskStartTime extends _$TaskStartTime {
  @override
  DateTime? build() => null;

  void changeTime(DateTime date) {
    state = date;
  }

  void reset() => state = null;
}

@riverpod
class TaskEndTime extends _$TaskEndTime {
  @override
  DateTime? build() => null;

  void changeTime(DateTime date) {
    state = date;
  }

  void reset() => state = null;
}
