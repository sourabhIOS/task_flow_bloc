import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle,onDelete,onUpdate;
  //final VoidCallback onDelete;
  //final VoidCallback onUpdate;

  const TaskListItem({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.status == TaskStatus.completed,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
                task.status == TaskStatus.completed
                    ? TextDecoration.lineThrough
                    : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null) Text(task.description!,style: TextStyle(
            decoration:
                task.status == TaskStatus.completed
                    ? TextDecoration.lineThrough
                    : null,
          ),),
            if (task.dueDate != null)
              Text('Due: ${task.dueDate!.toString().split(' ')[0]}',style: TextStyle(
            decoration:
                task.status == TaskStatus.completed
                    ? TextDecoration.lineThrough
                    : null,
          )),
            Text('Priority: ${task.priority.toString().split('.').last}',style: TextStyle(
            decoration:
                task.status == TaskStatus.completed
                    ? TextDecoration.lineThrough
                    : null,
          )),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onUpdate, // Call your update function here
            ),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
