import 'dart:async';
import 'package:beauty_salon/features/home/models/home_schedule_model.dart';

class HomeService {
  /// Replace with real API later.
  Future<List<HomeScheduleModel>> fetchTodaySchedules() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      HomeScheduleModel(
        id: '1',
        name: 'Eleanor Pena',
        service: 'Haircut & Color',
        timeText: '10:00 AM',
        status: AppointmentStatus.pending,
      ),
      HomeScheduleModel(
        id: '2',
        name: 'Cody Fisher',
        service: 'Manicure',
        timeText: '11:30 AM',
        status: AppointmentStatus.pending,
      ),
      HomeScheduleModel(
        id: '3',
        name: 'Jane Cooper',
        service: 'Facial',
        timeText: '09:00 AM',
        status: AppointmentStatus.completed,
      ),
      HomeScheduleModel(
        id: '4',
        name: 'Robert Fox',
        service: 'Beard Trim',
        timeText: '01:00 PM',
        status: AppointmentStatus.pending,
      ),
    ];
  }
}
