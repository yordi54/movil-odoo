import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movil_odoo/controllers/register_attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

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

  bool isAttendanceId() {
    return _registerAttendanceController.attendance.value!.isEmpty;
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
        title: const Text('Registro de Asistencia'),
      ),
      body: Obx(() {
        if (_registerAttendanceController.attendance.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (isAttendanceId()) {
            return Center(
              child: Column(
                children: [
                  const Text('No hay asistencias registradas'),
                  //boton
                  MaterialButton(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(16.0),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text('Crear Lista de Asistencia'),
                      onPressed: () {
                        SharedPreferences.getInstance().then(
                          (prefs) {
                            final String password =
                                prefs.getString('llave') ?? '';
                            final int id = prefs.getInt('id') ?? 0;
                            _registerAttendanceController
                                .createRegisterAttendance(
                                    id, password, int.parse(gradeId!));
                          },
                        );
                      })
                ],
              ),
            );
          }
        }
        return Column(
          children: [
            Center(
              child: Container(
                  width: context.width,
                  color: Colors.blueAccent[100],
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () async {
                              final imagePicker = ImagePicker();
                              final pickedFile = await imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 20);
                              if (pickedFile != null) {
                                File image = File(pickedFile.path);
                                Uint8List bytes = await image.readAsBytes();
                                String base64Image = base64Encode(bytes);
                                SharedPreferences.getInstance().then(
                                  (prefs) {
                                    final String password =
                                        prefs.getString('llave') ?? '';
                                    final int id = prefs.getInt('id') ?? 0;
                                    _registerAttendanceController.generateAttendanceIA(
                                        id,
                                        password,
                                        _registerAttendanceController
                                                .attendance.value![0].id ??
                                            0,
                                        base64Image,
                                        int.parse(gradeId!));
                                  },
                                ); 
                              }
                            },
                            child: const Text('Registrar con IA',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      const Center(
                          child: Text('Registro de Asistencias',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Curso: ',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(
                              '${_registerAttendanceController.attendance.value![0].gradeId[1] ?? ''}',
                              style: const TextStyle(fontSize: 16.0)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Fecha: ',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(
                              _registerAttendanceController
                                  .attendance.value![0].date,
                              style: const TextStyle(fontSize: 16.0)),
                        ],
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: Container(
                  color: Colors.redAccent[100],
                  padding: const EdgeInsets.all(16.0),
                  width: context.width,
                  height: context.height * 0.8,
                  child: ListView.builder(
                    itemCount: _registerAttendanceController
                        .attendance.value![0].attendances.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.greenAccent[100],
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: 300.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  PopupMenuButton(
                                    onSelected: (String result) {
                                      setState(() {
                                        if (result == 'attended') {
                                          SharedPreferences.getInstance().then(
                                            (prefs) {
                                              final String password =
                                                  prefs.getString('llave') ??
                                                      '';
                                              final int id =
                                                  prefs.getInt('id') ?? 0;
                                              _registerAttendanceController
                                                  .updateRegisterAttendance(
                                                      id,
                                                      password,
                                                      _registerAttendanceController
                                                              .attendance
                                                              .value![0]
                                                              .attendances[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      true,
                                                      false,
                                                      false);
                                            },
                                          );
                                          // Lógica para editar
                                        } else if (result == 'missing') {
                                          SharedPreferences.getInstance().then(
                                            (prefs) {
                                              final String password =
                                                  prefs.getString('llave') ??
                                                      '';
                                              final int id =
                                                  prefs.getInt('id') ?? 0;
                                              _registerAttendanceController
                                                  .updateRegisterAttendance(
                                                      id,
                                                      password,
                                                      _registerAttendanceController
                                                              .attendance
                                                              .value![0]
                                                              .attendances[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      false,
                                                      false,
                                                      true);
                                            },
                                          );
                                        } else if (result == 'leave') {
                                          // Lógica para eliminar
                                          SharedPreferences.getInstance().then(
                                            (prefs) {
                                              final String password =
                                                  prefs.getString('llave') ??
                                                      '';
                                              final int id =
                                                  prefs.getInt('id') ?? 0;
                                              _registerAttendanceController
                                                  .updateRegisterAttendance(
                                                      id,
                                                      password,
                                                      _registerAttendanceController
                                                              .attendance
                                                              .value![0]
                                                              .attendances[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      false,
                                                      true,
                                                      false);
                                            },
                                          );
                                        }
                                      });
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'attended',
                                        child: Text('Asistio'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'missing',
                                        child: Text('Falto'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'leave',
                                        child: Text('Licencia'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                  child: userImage(_registerAttendanceController
                                          .attendance
                                          .value![0]
                                          .attendances[index]
                                          .studentId[2] ??
                                      '')),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nombre: ',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      _registerAttendanceController
                                              .attendance
                                              .value![0]
                                              .attendances[index]
                                              .studentId[1] ??
                                          '',
                                      style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Asistencia: ',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      _registerAttendanceController
                                              .attendance
                                              .value![0]
                                              .attendances[index]
                                              .attended
                                          ? 'Asistio'
                                          : 'Ninguno',
                                      style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Falta: ',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      _registerAttendanceController
                                              .attendance
                                              .value![0]
                                              .attendances[index]
                                              .missing
                                          ? 'Falto'
                                          : 'Ninguno',
                                      style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Licencia: ',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      _registerAttendanceController
                                              .attendance
                                              .value![0]
                                              .attendances[index]
                                              .leave
                                          ? 'Licencia'
                                          : 'Ninguno',
                                      style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
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

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      Uint8List bytes = await image.readAsBytes();
      final String base64Image = base64Encode(bytes);
      log(base64Image);
    }
  }
}
