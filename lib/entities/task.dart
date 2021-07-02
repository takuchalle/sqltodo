import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({required String name, required int done, int? id}) =
      _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
