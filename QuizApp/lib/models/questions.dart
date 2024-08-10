class Questions {
  final String question;
  final List<String> answers;
  bool chooseOption = false;

  List<String> shuffledList() {
    List<String> v = List.of(answers);
    v.shuffle();
    return v;
  }

  void chooseanswer() {
    chooseOption = true;
  }

  Questions(this.question, this.answers);
}
