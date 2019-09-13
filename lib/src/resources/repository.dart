import 'package:todo_list/src/models/todo_model.dart';
import 'package:todo_list/src/resources/hasura_provider.dart';

class Repository {
  HasuraProvider _hasuraProvider = HasuraProvider();

  Stream<List<TodoModel>> show({String date}) => _hasuraProvider.getTodos(date);

  Future create(String title, String description) =>
      _hasuraProvider.createTodo(title, description);

  Future delete(int id) => _hasuraProvider.deleteTodo(id);

  Future complete(int id, bool completed) =>
      _hasuraProvider.completeTodo(id, completed);

  void dispose() {
    _hasuraProvider.dispose();
  }
}
