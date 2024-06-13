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
    return '${_authController.user.value!.completeName} | Guardian' ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenuGuardian(),
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        )
      ),
      
    );
  }
}
