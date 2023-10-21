class ToDo {
  String id;
  String tag;
  String title;
  String description;
  bool isCompleted;
  DateTime time;
  DateTime createdAt;
  DateTime updatedAt;

  ToDo({
    required this.id,
    required this.tag,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });
}
