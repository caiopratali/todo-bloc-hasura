import 'dart:convert';

TodoModel todoModelFromJson(String string) =>
    TodoModel.fromJson(json.decode(string));
String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  int _id;
  String _title;
  String _description;
  bool _completed;

  TodoModel({int id, String title, String description, bool completed}) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._completed = completed;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get description => _description;
  set description(String description) => _description = description;
  bool get completed => _completed;
  set completed(bool completed) => _completed = completed;

  TodoModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['description'] = this._description;
    data['completed'] = this._completed;
    return data;
  }

  static List<TodoModel> fromJsonList(List list) {
    if (list == null) {
      return null;
    } else {
      return list.map((item) => TodoModel.fromJson(item)).toList();
    }
  }
}
