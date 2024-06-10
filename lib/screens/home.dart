//page home

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movil_odoo/controllers/auth.controller.dart';
class HomePage extends StatelessWidget {
  final AuthController _authController = Get.find();

  HomePage({super.key});

  //function obtener usuario string
  String username() {
    //concaternar el nombre y apellido
    return _authController.user.value!.completeName ;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido ${username()}' , style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              ),
              onPressed: () {
                _authController.logout();
              },
              child: const Text('Cerrar sesión', style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
