//page home

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movil_odoo/controllers/auth.controller.dart';
import 'package:movil_odoo/screens/sidebar_menu_guardian.dart';
class HomePageGuardian extends StatelessWidget {
  final AuthController _authController = Get.find();

  HomePageGuardian({super.key});

  //function obtener usuario string
  String username() {
    return '${_authController.userGuardian.value!.name} ${_authController.userGuardian.value!.lastname} ' ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenuGuardian(),
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.teal ,
        title: const Text('Home', style: TextStyle(color: Colors.white)),
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
            Text('Bienvenido, ${username()}' , style: const TextStyle(fontSize: 24 ), textAlign:  TextAlign.center),
            
          ],
        ),
      )
      
    );
  }
}
