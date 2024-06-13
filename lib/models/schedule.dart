class Schedule {
  final int? id;
  final String startTime;
  final String endTime;
  final String day;
  final List<dynamic> subjectId;
  final List<dynamic> classroomId;
  final List<dynamic> gradeId;

  Schedule({
    this.id,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.subjectId,
    required this.classroomId,
    required this.gradeId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      day: json['day'],
      subjectId: json['subject_id'],
      classroomId: json['classroom_id'],
      gradeId: json['grade_id'],
    );
  }
  
}