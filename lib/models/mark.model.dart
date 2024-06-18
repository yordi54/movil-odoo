
class Mark {
  final int id;
  final int number;
  final List <dynamic>subjectId;

  Mark({
    required this.id,
    required this.number,
    required this.subjectId,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      id: json['id'],
      number: json['number'],
      subjectId: json['subject_id'],
    );
  }

}