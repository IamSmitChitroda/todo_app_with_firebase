class Todo {
  String id, title;
  bool status;
  int dTime;

  Todo(this.id, this.title, this.status, this.dTime);

  factory Todo.fromMap(Map data) => Todo(
        data['id'] ?? "000",
        data['title'] ?? "undefined",
        data['status'] ?? false,
        data['d_time'] ?? 111,
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'status': status,
        'd_time': dTime,
      };
}
