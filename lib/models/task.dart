import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high
}

@HiveType(typeId: 1)
enum TaskStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  completed
}

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final DateTime? dueDate;

  @HiveField(3)
  final Priority priority;

  @HiveField(4)
  final TaskStatus status;

  Task({
    required this.title,
    this.description,
    this.dueDate,
    this.priority = Priority.medium,
    this.status = TaskStatus.pending,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    TaskStatus? status,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
} 