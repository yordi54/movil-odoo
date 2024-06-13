import 'package:movil_odoo/models/attendance.model.dart';

class RegisterAttendance {
  final int? id;
  final String name;
  final String date;
  final List<dynamic> gradeId;
  final List<Attendance> attendances;

  RegisterAttendance({
    this.id,
    required this.name,
    required this.date,
    required this.gradeId,
    required this.attendances,
  });

  factory RegisterAttendance.fromJson(Map<String, dynamic> json) {
    List<Attendance> attendances = [];
    for (var attendance in json['attendances']) {
      attendances.add(Attendance.fromJson(attendance));
    }
    return RegisterAttendance(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      gradeId: json['grade_id'],
      attendances: attendances,
    );
  }

}