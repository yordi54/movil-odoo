import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final String password = prefs.getString('llave') ?? '';
      final int id = prefs.getInt('id') ?? 0;
      _gradeController.getGrades(id, password);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Asistencias'),
      ),
      drawer: const SideBarMenu(),
      // listview de cursos
      body: Obx(() {
        if (_gradeController.grades.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: _gradeController.grades.value!.length,
          itemBuilder: (context, index) {
            Grade grade = _gradeController.grades.value![index];
            return Card(
              color: Colors.greenAccent[100],
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:InkWell(
                onTap: () {
                  // Acción a realizar al tocar la tarjeta
                  
                  // Navegar a otra página o realizar cualquier acción deseada
                  Get.toNamed('/attendanceAdd/${grade.id}');
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child: Icon(
                          Icons.school,
                          size: 50.0,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Curso:',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                grade.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Ciclo:',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                grade.cycleId[1],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Paralelo:',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                grade.parallelId[1],
                                style: const TextStyle(fontSize: 18),
                              ),
                              // Puedes agregar más datos aquí si es necesario.
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
