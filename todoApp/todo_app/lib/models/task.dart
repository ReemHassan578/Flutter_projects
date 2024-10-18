class Task {
  //var id;
  final String title;
  final DateTime date;
  final String description;
  bool isComplete;
  //var startTime;
  //var endTime;
  //var remind;
  //var repeart;
  //var color;

  Task({
    required this.title,
    required this.date,
    required this.description,
  }) : isComplete = false;
  void completeTask() {
    isComplete = true;
  }
}
