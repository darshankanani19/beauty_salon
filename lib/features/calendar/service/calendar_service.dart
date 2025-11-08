import 'dart:async';
import 'package:beauty_salon/features/calendar/models/calendar_schedule_model.dart';

class CalendarService {
  Future<List<CalendarScheduleModel>> fetchAppointments(DateTime date) async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate API delay

    // Example response
    return [
      CalendarScheduleModel(
        id: '1',
        clientName: 'Riya Patel',
        service: 'Haircut',
        staffName: 'Sophia R.',
        timeFrom: '10:00 AM',
        timeTo: '11:00 AM',
      ),
      CalendarScheduleModel(
        id: '2',
        clientName: 'Amit Shah',
        service: 'Facial',
        staffName: 'David L.',
        timeFrom: '11:30 AM',
        timeTo: '12:15 PM',
      ),
    ];
  }

  Future<void> deleteAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Call DELETE API here later
  }
}
