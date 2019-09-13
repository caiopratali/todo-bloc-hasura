import 'package:flutter/material.dart';
import 'package:todo_list/src/blocs/todo_bloc.dart';
import 'package:todo_list/src/models/todo_model.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<TodoModel>>(
          stream: bloc.todosController,
          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          child: CheckboxListTile(
                            onChanged: (value) {
                              bloc.completeTodo(snapshot.data[index].id, value);
                            },
                            title: Text(snapshot.data[index].title),
                            subtitle: Text(snapshot.data[index].description),
                            value: snapshot.data[index].completed,
                          ),
                          key: Key(snapshot.data[index].title),
                          onDismissed: (direction) {
                            bloc.deleteTodo(snapshot.data[index].id);
                          },
                        );
                      },
                    ),
                  )
                ],
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return createTodo();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createTodo() {
    return AlertDialog(
      title: Center(child: Text('Create Todo')),
      content: Container(
        height: 180,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some title';
                  } else {
                    return null;
                  }
                },
                controller: bloc.titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some description';
                  } else {
                    return null;
                  }
                },
                controller: bloc.descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              bloc.createTodo();
              Navigator.of(context).pop();
            }
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
