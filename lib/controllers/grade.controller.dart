import 'package:get/get.dart';
import 'package:movil_odoo/models/grade.model.dart';
import 'package:movil_odoo/services/grade.service.dart';

class GradeController extends GetxController {
   var grades = Rxn<List<Grade>>();


  void getGrades(int id, String password, int teacherId) async {
    try {
      final response = await GradeService.getGrades(id, password,teacherId);
      if (response['result']!= false) {
        List<Grade> gradesList = [];
        for (var grade in response['result']) {
          gradesList.add(Grade.fromJson(grade));
        }
        grades(gradesList);
      } else {
        throw Exception('Failed to get grades');
      }
    } catch (e) {
      // ignore: avoid_print
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  

  
}