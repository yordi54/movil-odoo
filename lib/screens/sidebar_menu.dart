

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/auth.controller.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final user = authController.userEmployee.value!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.teal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                      child: CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.account_circle,
                        size: 80, color: Colors.grey),
                  )),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.app_registration_sharp),
            title: const Text('Registros Asistencias'),
            onTap: () {
              Get.toNamed('/attendance');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_sharp),
            title: const Text('Mis horario'),
            onTap: () {
              Get.toNamed('/schedule');
            },
          ),
          /* al final ,  poner salir */
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
