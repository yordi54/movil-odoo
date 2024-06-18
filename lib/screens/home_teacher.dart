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
    return '${_authController.userEmployee.value!.name} ' ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenu(),
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        elevation: 4.0,
        backgroundColor: Colors.teal ,
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
            Text('Bienvenido ${username()}' , style: const TextStyle(fontSize: 24 ), textAlign:  TextAlign.center),
            
          ],
        ),
      ),
    );
  }
}
