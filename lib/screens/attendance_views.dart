import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movil_odoo/controllers/register_attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final String? gradeId = Get.parameters['id'];
  final RegisterAttendanceController _registerAttendanceController =
      Get.put(RegisterAttendanceController());

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefs) {
        final String password = prefs.getString('llave') ?? '';
        final int id = prefs.getInt('id') ?? 0;
        _registerAttendanceController.getRegisterAttendance(
            id, password, int.parse(gradeId!));

      },
    );
  }

  

  //imagen base64
  Widget userImage(String? photo) {
    if (photo != null && photo.isNotEmpty) {
      Uint8List bytes = base64Decode(photo);
      return CircleAvatar(
        radius: 40,
        backgroundImage: MemoryImage(bytes),
      );
    } else {
      return const CircleAvatar(
        radius: 40,
        child: Icon(Icons.account_circle, size: 80, color: Colors.grey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Asistencia', style: TextStyle(color: Colors.white)),
        elevation: 4.0,
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (_registerAttendanceController.registerAttendance.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (_registerAttendanceController.registerAttendance.value!.isEmpty) {
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 50.0,
                    ),
                    Text(
                      'No hay registros de asistencia',
                      style:   TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () async {},
                      child:  const Text('Crear Registro de Asistencia',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ],
            );
          }
        }
        //mostrar cabezera datos de registros de asistencia
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blueAccent[100],
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child:  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.all(16.0),
                        color: Colors.blueAccent[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: ()  async {
                          await getImage();
                          
                        },
                        child: const Text('Registrar con IA',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _registerAttendanceController.registerAttendance.value![0].name.toUpperCase(),
                        style:  const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  const SizedBox(height:  4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Curso: ',
                        style: TextStyle( color: Colors.white,
                            fontSize: 16.0, fontWeight: FontWeight.bold,),
                      ),
                      Text(
                        '${_registerAttendanceController.registerAttendance.value![0].gradeId[1] ?? ''}',
                        style:  const TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Fecha: ',
                        style: TextStyle( color: Colors.white,
                            fontSize: 16.0, fontWeight: FontWeight.bold,),
                      ),
                      Text(
                        _registerAttendanceController.registerAttendance.value![0].date,
                        style: const TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),

            ),
            Expanded(
              child: ListView.builder(
                itemCount: _registerAttendanceController.registerAttendance.value![0].attendances.length,
                itemBuilder: (context, index) {
                  return  Card(
                    color: Colors.greenAccent[100],
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                        userImage(_registerAttendanceController.registerAttendance.value![0].attendances[index].studentId[2]),
                         const SizedBox(width: 16.0),
                         Expanded(
                          child: Column(
                            children: [
                              Text(_registerAttendanceController.registerAttendance.value![0].attendances[index].studentId[1] ,style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(height: 6.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: _registerAttendanceController.registerAttendance.value![0].attendances[index].attended ? Colors.green : Colors.grey,
                                ),
                                const SizedBox(width: 4.0),
                                Icon(
                                  Icons.cancel,
                                  color: _registerAttendanceController.registerAttendance.value![0].attendances[index].missing ? Colors.red : Colors.grey,
                                ),
                                const SizedBox(width: 4.0),
                                Icon(
                                  Icons.remove_circle,
                                  color: _registerAttendanceController.registerAttendance.value![0].attendances[index].leave ? Colors.blue : Colors.grey,
                                ),
                              ],
                            )
                            ],
                          ),
                         )
                        ],
                      ),
                    ),

                  );
                },
              )
            )
          ],
        );
        
  }),
    );
  }


  
  /* image ppicker */
  Future getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    ///la file para enviar al servidor, sin base64
    if (pickedFile != null) {
      final File file = File(pickedFile.path);
      //traer id de shared preferences
      SharedPreferences.getInstance().then(
        (prefs) {
          final String password = prefs.getString('llave') ?? '';
          final int id = prefs.getInt('id') ?? 0;
          _registerAttendanceController.generateAttendanceIA(id, password, _registerAttendanceController.registerAttendance.value![0].id, file);
        },
      );
       
    }
  }


}
