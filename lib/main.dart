import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/auth.controller.dart';
import 'package:movil_odoo/router.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MainApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      initialBinding: BindingsBuilder(() {
        // Inicializar el AuthController 
        Get.put(AuthController());
      }),
    );
  }
}
