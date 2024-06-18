
import 'package:get/get.dart';
import 'package:movil_odoo/screens/announcement_views.dart';
import 'package:movil_odoo/screens/attendance_views.dart';
import 'package:movil_odoo/screens/home_guardian.dart';
import 'package:movil_odoo/screens/home_teacher.dart';
import 'package:movil_odoo/screens/login.dart';
import 'package:movil_odoo/screens/note_views.dart';
import 'package:movil_odoo/screens/register_attendance_view.dart';
import 'package:movil_odoo/screens/schedule_views.dart';

class AppRoutes {
  static const String login = '/login';
  static const String homeTeacher = '/teacher';
  static const String homeGuardian = '/guardian';
  static const String registerAttendance = '/attendance';
  static const String schedule = '/schedule';
  static const String attendance = '/attendanceAdd/:id';
  static const String nota = '/nota';
  static const String announcement = '/announcement';

  static final routes = [
   
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: homeTeacher,
      page: () => const HomePageTeacher(),
    ),
    GetPage(
      name: homeGuardian,
      page: () => HomePageGuardian(),
    ),

    GetPage(name: registerAttendance 
    , page: ()=> const RegisterAttendancePage()
    ),
    GetPage(
      name: schedule,
      page: () => const SchedulePage(),
    ),
    GetPage(
      name: attendance,
      page: () => const AttendanceScreen(),
    ),
    GetPage(
      name: nota,
      page: () => const NotaScreen(),
    ),
    GetPage(
      name: announcement,
      page: () => const AnnouncementScreen(),
    ),

    
  ];
}