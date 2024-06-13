//page home

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movil_odoo/controllers/auth.controller.dart';
import 'package:movil_odoo/screens/sidebar_menu.dart';
class HomePageTeacher extends StatefulWidget {

  const HomePageTeacher({super.key});

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  final AuthController _authController = Get.find();

  //function obtener usuario string
  String username() {
    return '${_authController.user.value!.completeName} | Teacher' ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenu(),
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        )
      ),

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
