import 'package:get/get.dart';
import 'package:movil_odoo/models/schedule.dart';
import 'package:movil_odoo/services/schedule.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController extends GetxController {
  var schedules = Rxn<List<Schedule>>();

  @override
  void onInit() {
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      final String password = prefs.getString('llave') ?? '';
      final int id = prefs.getInt('id') ?? 0;
      getSchedules(id, password);
    });
  }


  void getSchedules(int id, String password) async {
    try {
      final response = await ScheduleService.getSchedules(id, password);
      if (response['result'] != false) {
        List<Schedule> schedulesList = [];
        for (var schedule in response['result']) {
          schedulesList.add(Schedule.fromJson(schedule));
        }
        schedules(schedulesList);
      } else {
        throw Exception('Failed to get schedules');
      }
    } catch (e) {
      // ignore: avoid_print
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}