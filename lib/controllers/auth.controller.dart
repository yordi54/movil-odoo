import 'package:get/get.dart';
import 'package:movil_odoo/models/user.model.dart';
import 'package:movil_odoo/router.dart';
import 'package:movil_odoo/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var user = Rxn<User>();
  var isLoading = false.obs;

  /* @override
  void onInit() {
    super.onInit();
    //checkLoginStatus();
  } */

  void login(String email, String password) async {
    try {
      isLoading(true);
      var response = await AuthService.login(email, password);
      if (response['result'] != false) {
        int id = response['result'];
        var userResponse = await AuthService.getUser(id, password);
        // ignore: avoid_print
        print(userResponse['result'][0]);
        user.value = User.fromJson(userResponse['result'][0]);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('llave', password);
        prefs.setInt('id', id);
        isLoggedIn(true);
        if (user.value!.employeeIds.isNotEmpty) {
          Get.offAllNamed(AppRoutes.homeTeacher);
        } else {
          Get.offAllNamed(AppRoutes.homeGuardian);
        }
      }else{
        //generar error
        throw Exception('Credenciales incorrectas');
      }
    } catch (e) {
      // ignore: avoid_print
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user'); // Obtener el JSON del usuario
    if (userJson != null) {
      // Convertir el JSON del usuario a un objeto User
      User userObject = User.fromJson(jsonDecode(userJson));
      // Asignar el objeto User al observable user
      user.value = userObject;
      isLoggedIn(true);
      //redirect
      if (userObject.employeeIds.isNotEmpty) {
        Get.offAllNamed(AppRoutes.homeTeacher);
      } else {
        Get.offAllNamed(AppRoutes.homeGuardian);
      }
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void logout() async {
    try {
      isLoading(true);
      await AuthService.logout();
      user.value = null;
      isLoggedIn(false);
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
