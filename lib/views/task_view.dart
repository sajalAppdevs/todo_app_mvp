import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/task_repository.dart';
import '../presenters/task_presenter.dart';

class TaskViewPage extends StatefulWidget {
  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> implements TaskView {
  late TaskPresenter _presenter;
  final TaskRepository _repository = TaskRepository();
  List<Task> _tasks = [];

  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _presenter = TaskPresenter(_repository, this);
    _presenter.loadTasks();
  }

  @override
  void updateTaskList(List<Task> tasks) {
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask() {
    final title = _taskController.text;
    if (title.isNotEmpty) {
      _presenter.addTask(title);
      _taskController.clear();
    }
  }

  void _toggleTaskCompletion(Task task) {
    _presenter.toggleTaskCompletion(task);
  }

  void _deleteTask(Task task) {
    _presenter.deleteTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App (MVP)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Enter task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            task.isCompleted
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                          onPressed: () => _toggleTaskCompletion(task),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTask(task),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
