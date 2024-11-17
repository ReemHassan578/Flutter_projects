class Task {
  int? id;
  final String title;
  final String date;
  final String time;
  String status;

  Task({required this.title, required this.date, required this.time})
      : status = 'new';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        title = map['title'] as String,
        date = map['date'] as String,
        time = map['time'] as String,
        status = map['status'] as String;
}
