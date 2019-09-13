import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:todo_list/src/models/todo_model.dart';
import 'package:intl/intl.dart';

class HasuraProvider {
  HasuraConnect connection = HasuraConnect(DotEnv().env['HASURA_URL']);

  Stream<List<TodoModel>> getTodos() {
    var query = '''
      subscription getTodos(\$date:date!){
        todos (where: {date: {_eq: \$date}}){
          id
          title
          description
          completed
        }
      }
    ''';

    Snapshot snapshot = connection.subscription(query, variables: {
      "date": new DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()
    });

    return snapshot.stream
        .map((jsonList) => TodoModel.fromJsonList(jsonList['data']['todos']));
  }

  Future createTodo(String title, String description) {
    var query = """
      mutation createTodo(\$title: String!, \$description: String!) {
        insert_todos(objects: {title: \$title, description: \$description}) {
          affected_rows
        }
      }
    """;

    return connection.mutation(query, variables: {
      "title": title,
      "description": description,
    });
  }

  Future deleteTodo(int id) {
    var query = """
    mutation deleteTodo(\$id: Int!){
      delete_todos(where: {id: {_eq: \$id}}) {
        affected_rows
      }
    }
    """;

    return connection.mutation(query, variables: {
      "id": id,
    });
  }

  Future completeTodo(int id, bool completed) {
    var query = """
      mutation completeTodo(\$id: Int!, \$completed: Boolean!){
        update_todos(_set: {completed: \$completed}, where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;

    return connection.mutation(query, variables: {
      "id": id,
      "completed": completed,
    });
  }

  void dispose() {
    connection.dispose();
  }
}
