import '../models/task.dart';
import '../models/task_repository.dart';

abstract class TaskView {
  void updateTaskList(List<Task> tasks);
}

class TaskPresenter {
  final TaskRepository _taskRepository;
  TaskView _view;

  TaskPresenter(this._taskRepository, this._view);

  void loadTasks() {
    _view.updateTaskList(_taskRepository.getTasks());
  }

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().millisecondsSinceEpoch, title: title);
    _taskRepository.addTask(newTask);
    loadTasks();
  }

  void updateTask(Task task) {
    _taskRepository.updateTask(task);
    loadTasks();
  }

  void deleteTask(Task task) {
    _taskRepository.deleteTask(task);
    loadTasks();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }
}
