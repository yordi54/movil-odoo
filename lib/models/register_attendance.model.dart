
import 'package:movil_odoo/models/attendance.model.dart';

class RegisterAttendance {
  final int id;
  final String name;
  final String date;
  final List<dynamic> gradeId;
  final List<dynamic> attendanceIds;
  List<Attendance> attendances;

  RegisterAttendance({
    required this.id,
    required this.name,
    required this.date,
    required this.gradeId,
    required this.attendanceIds,
    required this.attendances,
  });

  factory RegisterAttendance.fromJson(Map<String, dynamic> json) {
    List<Attendance> attendances = [];
    if (json['attendances'] != null) {
      json['attendances'].forEach((v) {
        attendances.add(Attendance.fromJson(v));
      });
    }
    return RegisterAttendance(
      id: json['register_attendance'][0]['id'],
      name: json['register_attendance'][0]['name'],
      date: json['register_attendance'][0]['date'],
      gradeId: json['register_attendance'][0]['grade_id'],
      attendanceIds: json['register_attendance'][0]['attendance_ids'],
      attendances: attendances,
    );
  }

}