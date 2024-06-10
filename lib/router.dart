
import 'package:get/get.dart';
import 'package:movil_odoo/screens/home.dart';
import 'package:movil_odoo/screens/home.guardian.dart';
import 'package:movil_odoo/screens/home.teacher.dart';
import 'package:movil_odoo/screens/login.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String homeTeacher = '/teacher';
  static const String homeGuardian = '/guardian';

  static final routes = [
    GetPage(
      name: home,
      page: () => HomePage(),
    ), 
     GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: homeTeacher,
      page: () => HomePageTeacher(),
    ),
    GetPage(
      name: homeGuardian,
      page: () => HomePageGuardian(),
    ),
    
  ];
}