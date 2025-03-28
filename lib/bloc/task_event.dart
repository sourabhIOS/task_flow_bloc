
import '../models/task.dart';

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final Task task;
  DeleteTask(this.task);
}

class ToggleTaskStatus extends TaskEvent {
  final Task task;
  ToggleTaskStatus(this.task);
} 