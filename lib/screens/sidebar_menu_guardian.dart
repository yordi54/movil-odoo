

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/auth.controller.dart';
class SideBarMenuGuardian extends StatelessWidget {
  const SideBarMenuGuardian({super.key});


  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final user = authController.userGuardian.value!;
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
                  Center(
                    child: Text(
                      '${user.name} ${user.lastname}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              )
             ),
          ListTile(
            leading: const Icon(Icons.announcement),
            title: const Text('Comunicados'),
            onTap: () {
              Get.toNamed('/announcement');
            },
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('Notas de mi hijo/a'),
            onTap: () {
              Get.toNamed('/nota');
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
