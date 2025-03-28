import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/task_bloc.dart';
import 'bloc/task_event.dart';
import 'bloc/task_state.dart';
import 'models/task.dart';
import 'services/hive_service.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/task_list_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
  
  runApp(MyApp(hiveService: hiveService));
}

class MyApp extends StatelessWidget {
  final HiveService hiveService;

  const MyApp({
    Key? key,
    required this.hiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(hiveService),
        child: const TaskListScreen(),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(
              child: Text('No tasks avaiable. Add a new task!'),
            );
          }

          return ListView.builder(
          
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return TaskListItem(
                
                task: task,
                onToggle: () {
                  context.read<TaskBloc>().add(ToggleTaskStatus(task));
                },
                onDelete: () {
                  context.read<TaskBloc>().add(DeleteTask(task));
                },
                onUpdate: () async {
                  final updatedTask = await showDialog<Task>(
                    context: context,
                    builder: (context) => AddTaskDialog(task: task),
                  );
                  if (updatedTask != null) {
                    context.read<TaskBloc>().add(UpdateTask(updatedTask));
                  }
                }
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final task = await showDialog<Task>(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
          if (task != null) {
            context.read<TaskBloc>().add(AddTask(task));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
