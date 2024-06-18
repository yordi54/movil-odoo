import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/guadian.controller.dart';
import 'package:movil_odoo/screens/sidebar_menu_guardian.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  GuardianController guardianController = Get.put(GuardianController());
  @override 
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final int id = prefs.getInt('id') ?? 0;
      final String password = prefs.getString('llave') ?? '';
      guardianController.getAnnouncements(id, password);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenuGuardian(),
      appBar: AppBar(
        title:
            const Text('Comunicados', style: TextStyle(color: Colors.white)),
        elevation: 4.0,
        backgroundColor: Colors.teal,
      ),
      body: Obx((){
        if (guardianController.announcements.value == null) {
          return const Center(child: CircularProgressIndicator());
        }else if (guardianController.announcements.value!.isEmpty) {
          return const Center(child: Text('No hay comunicados'));
        }
        return ListView.builder(
          itemCount: guardianController.announcements.value!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              color: Colors.greenAccent,
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guardianController.announcements.value![index].reason,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      guardianController.announcements.value![index].description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            );
          },
        );
      })
    );
  }
}
