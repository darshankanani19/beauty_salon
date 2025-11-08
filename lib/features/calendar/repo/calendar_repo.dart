import 'package:beauty_salon/features/calendar/models/calendar_schedule_model.dart';
import 'package:beauty_salon/features/calendar/service/calendar_service.dart';

class CalendarRepo {
  final CalendarService service;
  CalendarRepo(this.service);

  Future<List<CalendarScheduleModel>> getAppointments(DateTime date) {
    return service.fetchAppointments(date);
  }

  Future<void> deleteAppointment(String id) {
    return service.deleteAppointment(id);
  }
}
