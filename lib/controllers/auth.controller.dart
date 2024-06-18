import 'package:get/get.dart';
import 'package:movil_odoo/models/employee.model.dart';
import 'package:movil_odoo/models/guardian.model.dart';
import 'package:movil_odoo/router.dart';
import 'package:movil_odoo/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmployee = Rxn<Employee>();
  var userGuardian = Rxn<Guardian>();
  var isLoading = false.obs;



  void login(String email, String password) async {
    try {
      isLoading(true);
      var response = await AuthService.login(email, password);
      if (response['result'].length > 0) {
        String? workEmail = response['result'][0]['work_email'];
        if(workEmail != null){
          userEmployee.value = Employee.fromJson(response['result'][0]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('llave', password);
          prefs.setInt('id', userEmployee.value!.userId[0]);
          Get.offAllNamed(AppRoutes.homeTeacher);
        }else{
          userGuardian.value = Guardian.fromJson(response['result'][0]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('llave', password);
          prefs.setInt('id', userGuardian.value!.userId[0]);
          Get.offAllNamed(AppRoutes.homeGuardian);

        }
        isLoggedIn(true);
      }else{
        //generar error
        throw Exception('Credenciales incorrectas');
      }
    } catch (e) {
      //si es error 400 mostrar mensaje de credenciales incorrectas
      if (e.toString().contains('400')) {
        Get.snackbar('Error', 'Credenciales incorrectas', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading(false);
    }
  }

  

  void logout() async {
    try {
      isLoading(true);
      await AuthService.logout();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('llave');
      prefs.remove('id');
      userEmployee.value = null;
      userGuardian.value = null;
      isLoggedIn(false);
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
