import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/auth.controller.dart';
import 'package:movil_odoo/controllers/guadian.controller.dart';
import 'package:movil_odoo/models/period.model.dart';
import 'package:movil_odoo/models/student.model.dart';
import 'package:movil_odoo/screens/sidebar_menu_guardian.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotaScreen extends StatefulWidget {
  const NotaScreen({super.key});

  @override
  State<NotaScreen> createState() => _NotaScreenState();
}

class _NotaScreenState extends State<NotaScreen> {
  GuardianController guardianController = Get.put(GuardianController());
  AuthController authController = Get.find();
  Student? selectStudent;
  Period? selectPeriod;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      final int id = prefs.getInt('id') ?? 0;
      final String password = prefs.getString('llave') ?? '';


      guardianController.getStudents(id, password, authController.userGuardian.value!.id);
      guardianController.students.listen((students) {
      if (students != null && students.isNotEmpty) {
        setState(() {
          selectStudent = students.first;
        });
      }

      guardianController.getPeriods(id, password);
      guardianController.periods.listen((periods) {
        if (periods != null && periods.isNotEmpty) {
          setState(() {
            selectPeriod = periods.first;
          });
        }});




    });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenuGuardian(),
      appBar: AppBar(
        title: const Text('Notas de mi hijo/a',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (guardianController.students.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Selecciona un periodo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                value: selectPeriod?.id,
                items: guardianController.periods.value!
                    .map(
                      (Period period) => DropdownMenuItem(
                        value: period.id,
                        child: Text(period.name),
                      ),
                    )
                    .toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectPeriod = guardianController.periods.value!
                        .firstWhere((element) => element.id == value);
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Selecciona un estudiante',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                value: selectStudent?.id,
                items: guardianController.students.value!
                    .map(
                      (Student student) => DropdownMenuItem(
                        value: student.id,
                        child: Text('${student.name} ${student.lastname}'),
                      ),
                    )
                    .toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectStudent = guardianController.students.value!
                        .firstWhere((element) => element.id == value);
                  });
                },
              ),
              const SizedBox(height: 20),
              MaterialButton(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  //bloqueado si no hay estudiante seleccionado y periodo seleccionado
                  if (selectStudent == null || selectPeriod == null) {
                    Get.snackbar('Error', 'Por favor, selecciona un estudiante y un periodo',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }else{
                    //llamar a la funcion que obtiene las notas
                    SharedPreferences.getInstance().then((prefs) {
                      final int id = prefs.getInt('id') ?? 0;
                      final String password = prefs.getString('llave') ?? '';
                      guardianController.getMarks(id, password, selectStudent!.id, selectPeriod!.id);
                    });
                  }
                  
                },
                color: Colors.teal,
                textColor: Colors.white,
                child: const  Text('Filtrar', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx((){
                  if (guardianController.marks.value == null || guardianController.marks.value!.isEmpty) {
                    return const Center(child: Text('No hay notas disponibles'));
                  }
                  return ListView.builder(
                    itemCount: guardianController.marks.value!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4.0,
                        child: Container(
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.greenAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Materia: ${guardianController.marks.value![index].subjectId[1]}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Text('Nota: ${guardianController.marks.value![index].number}', style: const TextStyle(fontSize: 16)),
                              ],
                            )
                          ),
                          
                        )
                      );
                    },
                  );
                
                }),

              )
            ],
          );
        }),
      ),
    );
  }
}
