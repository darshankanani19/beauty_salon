import 'package:beauty_salon/features/calendar/models/calendar_schedule_model.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState {
  final CalendarStatus status;
  final List<CalendarScheduleModel> appointments;
  final DateTime selectedDate;
  final String? error;

  const CalendarState({
    this.status = CalendarStatus.initial,
    this.appointments = const [],
    required this.selectedDate,
    this.error,
  });

  CalendarState copyWith({
    CalendarStatus? status,
    List<CalendarScheduleModel>? appointments,
    DateTime? selectedDate,
    String? error,
  }) {
    return CalendarState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      selectedDate: selectedDate ?? this.selectedDate,
      error: error,
    );
  }
}
