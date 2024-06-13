class Grade {
  final int ? id;
  final String name;
  final List<dynamic> parallelId;
  final List<dynamic> cycleId;
  final List<dynamic> registerAttendanceIds;


  Grade({
    this.id,
    required this.name,
    required this.parallelId,
    required this.cycleId,
    required this.registerAttendanceIds,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      name: json['name'],
      parallelId: json['parallel_id'],
      cycleId: json['cycle_id'],
      registerAttendanceIds: json['register_attendance_ids'],
    );
  }
}