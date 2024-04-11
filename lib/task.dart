class Task {
  final int id;
  final String title;
  final bool completed;

  Task({required this.id, required this.title, this.completed = false});

  /// Creates a [Task] from json map
  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(id: json['id'] as int, title: json['title'] as String, completed: json['completed'] as bool);

  /// Creates a json map from a [Task]
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'title': title, 'completed': completed};

  @override
  String toString() {
    return 'Task $id, "$title" is ${completed ? "completed" : "not completed"}';
  }
}
