import 'dart:convert';

List<Todos> todosFromJson(String str) =>
    List<Todos>.from(json.decode(str).map((x) => Todos.fromJson(x)));

Todos todoFromJson(String str) => Todos.fromJson(json.decode(str));

String todosToJson(List<Todos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todos {
  int userId;
  int id;
  String title;
  bool completed;

  Todos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
