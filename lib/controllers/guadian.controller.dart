

import 'package:get/get.dart';
import 'package:movil_odoo/models/announcement.model.dart';
import 'package:movil_odoo/models/mark.model.dart';
import 'package:movil_odoo/models/period.model.dart';
import 'package:movil_odoo/models/student.model.dart';
import 'package:movil_odoo/services/guardian.service.dart';

class GuardianController extends GetxController {

  var students = Rxn<List<Student>>();
  var periods = Rxn<List<Period>>();
  var marks = Rxn<List<Mark>>();
  var announcements = Rxn<List<Announcement>>();

  void getStudents(int id, String password, int guardianId) async {
    try {
      final response = await GuardianService.getStudents(id, password, guardianId);
      if (response['result'] != false) {
        if ( response['result'].length > 0) {
          List<Student> studentsList = [];
          for (var student in response['result']) {
            studentsList.add(Student.fromJson(student));
          }
          students(studentsList);

        } else {
          students([]);
        }
      } else {
        throw Exception('Failed to get students');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  void getPeriods(int id, String password) async {
    try {
      final response = await GuardianService.getPeriods(id, password);
      if (response['result'] != false) {
        if ( response['result'].length > 0) {
          List<Period> periodsList = [];
          for (var period in response['result']) {
            periodsList.add(Period.fromJson(period));
          }
          periods(periodsList);

        } else {
          periods([]);
        }
      } else {
        throw Exception('Failed to get periods');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void getMarks(int id, String password, int studentId, int periodId) async {
    try {
      final response = await GuardianService.marks(id, password, studentId, periodId);
      if (response['result'] != false) {
        if ( response['result'].length > 0) {
          List<Mark> marksList = [];
          for (var mark in response['result']) {
            marksList.add(Mark.fromJson(mark));
          }
          marks(marksList);

        } else {
          marks([]);
        }
      } else {
        throw Exception('Failed to get marks');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void getAnnouncements(int id, String password) async {
    try {
      final response = await GuardianService.getAnnouncement(id, password);
      if (response['result'] != false) {
        if ( response['result'].length > 0) {
          List<Announcement> announcementsList = [];
          for (var announcement in response['result']) {
            announcementsList.add(Announcement.fromJson(announcement));
          }
          announcements(announcementsList);

        } else {
          announcements([]);
        }
      } else {
        throw Exception('Failed to get announcements');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  
  
}