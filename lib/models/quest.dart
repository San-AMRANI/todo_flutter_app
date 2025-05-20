class Quest {
  final String id;
  final String title;
  final String description;
  bool isDone;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
