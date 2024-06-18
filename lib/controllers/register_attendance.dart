import 'dart:io';

import 'package:get/get.dart';
import 'package:movil_odoo/models/attendance.model.dart';
import 'package:movil_odoo/models/register_attendance.model.dart';
import 'package:movil_odoo/services/register_attendance.service.dart';

class RegisterAttendanceController extends GetxController {
  var registerAttendance = Rxn<List<RegisterAttendance>>();
  var attendance = Rxn<List<Attendance>>();

  void createRegisterAttendance(int id, String password, int gradeId) async {
    try {
      final response = await RegisterAttendanceService.createRegisterAttendance(
          id, password, gradeId);
      if (response['result'] != false) {
        //mostrar mensaje de exito
        Get.back();

        Get.snackbar('Success', 'Registro Creado exitosamente', snackPosition: SnackPosition.BOTTOM);
        //y que vuelva atras
      }else{
        throw Exception('Failed to create register attendance');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void  getRegisterAttendance(int id, String password, int gradeId) async {
    try {
      final response = await RegisterAttendanceService.getRegisterAttendance(id, password, gradeId);
      if (response['result'] != false) {
        ///insertar solo el index 0 de la lista de asistencias
        ///para que no se duplique la lista
        if(response['result']['register_attendance'].length > 0 && response['result']['attendances'].length > 0){
          //añadir al register su lista de asistencias
          List<RegisterAttendance> registerAttendanceList = [];
          registerAttendanceList.add(RegisterAttendance.fromJson(response['result']));
          registerAttendance(registerAttendanceList);
        }else{
          registerAttendance([]);
        }

      } else {
        throw Exception('Failed to get register attendance');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> getAttendance(int id, String password, int registerAttendanceId ) async{
    try {
      final response = await RegisterAttendanceService.getAttendance(id, password, registerAttendanceId);
      if (response['result'] != false) {
        //actualizar la lista de asistencias para que se refleje el cambio sin que el usuario tenga que recargar la pagina
        if(response['result'].length > 0){
          //añadir la lista de asistencias a la variable attendance toda la lista
          attendance(response['result'].map((item) => Attendance.fromJson(item)).toList());

        }else {
          attendance([]);
        }
      }else{
        throw Exception('Failed to get attendance');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

  }

  /* void updateRegisterAttendance(int id, String password, int attendanceId, bool attended, bool leave, bool missing) async {
    try {
      final response = await RegisterAttendanceService.updateAttendanceStudent(id, password, attendanceId, attended, leave, missing);
      if (response['result'] != false) {
        //actualizar la lista de asistencias para que se refleje el cambio sin que el usuario tenga que recargar la pagina
        getRegisterAttendance(id, password, attendance.value![0].gradeId[0] );

        Get.snackbar('Success', 'Se actualizo correctamente', snackPosition: SnackPosition.BOTTOM);
        //y que vuelva atras
      }else{
        throw Exception('Failed to update register attendance');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  } */

   /*void generateAttendanceIA(int id, String password, int registerAttendanceId, String photo, int gradeId) async {
    try {
      final response = await RegisterAttendanceService.generateAttendanceIA(id, password, registerAttendanceId, photo);
      if (response['result'] != false) {
        //actualizar la lista de asistencias para que se refleje el cambio sin que el usuario tenga que recargar la pagina
        getRegisterAttendance(id, password, gradeId);

        Get.snackbar('Success', 'Se genero la asistencia correctamente', snackPosition: SnackPosition.BOTTOM);
        //y que vuelva atras
      }else{
        throw Exception('Failed to generate attendance');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  } */

 void generateAttendanceIA( int id, String password, int registerAttendanceId, File photo) async {
    try {
      final response = await RegisterAttendanceService.generateAttendanceIA(id, password, registerAttendanceId, photo);
      if( response['result'] != false){
        Get.back();
        Get.snackbar('Success', 'Se genero la asistencia correctamente', snackPosition: SnackPosition.BOTTOM);

        //getRegisterAttendance(id, password, registerAttendanceId);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

 }
}
