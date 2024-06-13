import 'package:get/get.dart';
import 'package:movil_odoo/models/grade.model.dart';
import 'package:movil_odoo/services/grade.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradeController extends GetxController {
   var grades = Rxn<List<Grade>>();

  @override
  void onInit() {
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      final String password = prefs.getString('llave') ?? '';
      final int id = prefs.getInt('id') ?? 0;
      getGrades(id, password);
    });
  }

  void getGrades(int id, String password) async {
    try {
      final response = await GradeService.getGrades(id, password);
      if (response['result'] != false) {
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