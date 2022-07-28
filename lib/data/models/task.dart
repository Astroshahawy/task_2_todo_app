class Task {
  int? id;
  String title;
  String date;
  String startTime;
  String endTime;
  int color;
  int remind;
  bool isCompleted;
  bool isFavorite;

  Task({
    this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.isCompleted,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'isCompleted': isCompleted ? 1 : 0,
      'isFavorite': isFavorite? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      color: map['color'],
      remind: map['remind'],
      isCompleted: map['isCompleted'] == 0 ? false : true,
      isFavorite: map['isFavorite'] == 0 ? false : true,
    );
  }
}
