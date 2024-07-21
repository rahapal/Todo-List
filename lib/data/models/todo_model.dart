class TodoModel {
  final String id;
  final String date;
  final String note;

  TodoModel({
    required this.id,
    required this.date,
    required this.note,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"],
      date: json['date'],
      note: json['note'],
    );
  }
}
