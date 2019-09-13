import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_list/src/models/todo_model.dart';
import 'package:todo_list/src/resources/repository.dart';
import 'package:intl/intl.dart';

class TodoBloc {
  final Repository _repository = Repository();

  TodoBloc() {
    Observable(_repository.show(date: date)).pipe(todosController);
  }

  String date = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var todosController = BehaviorSubject<List<TodoModel>>();

  void createTodo() {
    _repository.create(titleController.text, descriptionController.text);
    titleController.clear();
    descriptionController.clear();
  }

  void deleteTodo(int id) => _repository.delete(id);

  void completeTodo(int id, bool completed) =>
      _repository.complete(id, completed);

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    todosController.close();
  }
}

TodoBloc bloc = TodoBloc();
