import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/auth.controller.dart';
import 'package:movil_odoo/controllers/grade.controller.dart';
import 'package:movil_odoo/models/grade.model.dart';
import 'package:movil_odoo/screens/sidebar_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterAttendancePage extends StatefulWidget {
  const RegisterAttendancePage({super.key});

  @override
  State<RegisterAttendancePage> createState() => _RegisterAttendancePageState();
}

class _RegisterAttendancePageState extends State<RegisterAttendancePage> {
  final GradeController _gradeController = Get.put(GradeController());
  final AuthController _authController = Get.find();
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final String password = prefs.getString('llave') ?? '';
      final int id = prefs.getInt('id') ?? 0;
      _gradeController.getGrades(
          id, password, _authController.userEmployee.value!.id);
    });
  }

  String getName(Grade grade) {
    // Retorna el nombre del curso PRimero - Secundaria - Amarillo ,  obtener los valores separado por un guion que tiene en grade
    var parts = grade.gradeId[1].split('-').map((e) => e.trim()).toList();
    return '${parts[0]}';
  }

  String getGrade(Grade grade) {
    // Retorna el nombre del curso PRimero - Secundaria - Amarillo ,  obtener los valores separado por un guion que tiene en grade
    var parts = grade.gradeId[1].split('-').map((e) => e.trim()).toList();
    return '${parts[1]}';
  }

  String getParallel(Grade grade) {
    // Retorna el nombre del curso PRimero - Secundaria - Amarillo ,  obtener los valores separado por un guion que tiene en grade
    var parts = grade.gradeId[1].split('-').map((e) => e.trim()).toList();
    return '${parts[2]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos', style: TextStyle(color: Colors.white)),
        elevation: 4.0,
        backgroundColor: Colors.teal,
      ),
      drawer: const SideBarMenu(),
      // listview de cursos
      body: Obx(() {
        if (_gradeController.grades.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_gradeController.grades.value!.isEmpty) {
          return const Center(
            child: Text('No hay cursos'),
          );
        }
        return ListView.builder(
          itemCount: _gradeController.grades.value!.length,
          itemBuilder: (context, index) {
            Grade grade = _gradeController.grades.value![index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.all(12.0 ),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                  onTap: () {
                    // Acción a realizar al tocar la tarjeta

                    // Navegar a otra página o realizar cualquier acción deseada
                    Get.toNamed('/attendanceAdd/${grade.gradeId[0]}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent[100],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.school,
                              size: 50,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getName(grade),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Grado: ${getGrade(grade)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Paralelo: ${getParallel(grade)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )),
            );
          },
        );
      }),
    );
  }
}
