class TaskModel {
  final int id;
  String title;
  String description;
  String status;
  String dueDate;
  final String createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? 'pending',
      dueDate: json['due_date']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }

  bool get isDone => status == 'done';
}