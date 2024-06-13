
class Attendance{
  final int ? id;
  final bool attended;
  final bool leave;
  final bool missing;
  final List<dynamic> studentId;

  Attendance({
    this.id,
    required this.attended,
    required this.leave,
    required this.missing,
    required this.studentId,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      attended: json['attended'],
      leave: json['leave'],
      missing: json['missing'],
      studentId: json['student_id'],
    );
  }

}