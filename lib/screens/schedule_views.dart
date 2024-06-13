import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_odoo/controllers/schedule.controller.dart';
import 'package:movil_odoo/helpers/meeting.dart';
import 'package:movil_odoo/helpers/meeting_data_source.dart';
import 'package:movil_odoo/screens/sidebar_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final ScheduleController _scheduleController = Get.put(ScheduleController());

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final String password = prefs.getString('llave') ?? '';
      final int id = prefs.getInt('id') ?? 0;
      _scheduleController.getSchedules(id, password);
    });
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Valor de rojo (0-255)
      random.nextInt(256), // Valor de verde (0-255)
      random.nextInt(256), // Valor de azul (0-255)
      1.0, // Opacidad (0.0 - 1.0)
    );
  }

  List<DateTime> _getWeekDates() {
    final List<DateTime> weekDates = [];
    final DateTime now = DateTime.now();
    final int currentWeekday = now
        .weekday; // Obtén el número del día de la semana actual (1 para lunes, 2 para martes, etc.)
    final DateTime mondayDate = now.subtract(Duration(
        days: currentWeekday - 1)); // Obtén la fecha del lunes de esta semana

    // Agrega la fecha de cada día de la semana a la lista
    for (int i = 0; i < 7; i++) {
      weekDates.add(mondayDate.add(Duration(days: i)));
    }

    return weekDates;
  }

  DateTime getDate(String day) {
    final List<String> days = [
      'lunes',
      'martes',
      'miercoles',
      'jueves',
      'viernes',
      'sabado',
      'domingo'
    ];
    //que devuelva la position del dia en la lista
    final int position = days.indexOf(day);
    final listWeek = _getWeekDates();
    return listWeek[position];
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    _scheduleController.schedules.value?.forEach((schedule) {
      final DateTime today = getDate(schedule.day);
      final DateTime startTime = DateTime(
          today.year,
          today.month,
          today.day,
          int.parse(schedule.startTime.split(':')[0]),
          int.parse(schedule.startTime.split(':')[1]));
      final DateTime endTime = DateTime(
          today.year,
          today.month,
          today.day,
          int.parse(schedule.endTime.split(':')[0]),
          int.parse(schedule.endTime.split(':')[1]));
      meetings.add(Meeting('${schedule.subjectId[1]} ${schedule.gradeId[1]} ',
          startTime, endTime, generateRandomColor(), false));
    });
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horario'),
      ),
      drawer: const SideBarMenu(),
      body: Obx(() {
        if (_scheduleController.schedules.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SfCalendar(
        view: CalendarView.schedule,
        scheduleViewSettings: const ScheduleViewSettings(
          appointmentItemHeight: 70,
        ),
        timeSlotViewSettings: const TimeSlotViewSettings(
          startHour: 7,
          endHour: 14,
          timeInterval: Duration(minutes: 30),
          timeFormat: 'HH:mm',
          nonWorkingDays: <int>[DateTime.sunday],
        ),
        dataSource: MeetingDataSource(_getDataSource()),
      );
      }),
    );
  }
}


