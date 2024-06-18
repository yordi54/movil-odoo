class Grade {
  final List<dynamic> gradeId;


  Grade({
    required this.gradeId,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      gradeId: json['grade_id'],
    );
  }
}