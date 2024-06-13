import 'package:get/get.dart';
import 'package:movil_odoo/models/register_attendance.model.dart';
import 'package:movil_odoo/services/register_attendance.service.dart';

class RegisterAttendanceController extends GetxController {
  var attendance = Rxn<List<RegisterAttendance>>();

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
        List<RegisterAttendance> attendanceList = [];
        for (var attendance in response['result']) {
          attendanceList.add(RegisterAttendance.fromJson(attendance));
        }
        attendance(attendanceList);
      } else {
        throw Exception('Failed to get register attendance');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateRegisterAttendance(int id, String password, int attendanceId, bool attended, bool leave, bool missing) async {
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
  }

  void generateAttendanceIA(int id, String password, int registerAttendanceId, String photo, int gradeId) async {
    try {
      print('id: $id, password: $password, registerAttendanceId: $registerAttendanceId, photo: $photo');
      final response = await RegisterAttendanceService.generateAttendanceIA(id, password, registerAttendanceId, photo);
      print(response);
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
  }
}
