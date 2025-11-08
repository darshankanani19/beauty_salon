import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beauty_salon/features/calendar/repo/calendar_repo.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final CalendarRepo repo;
  CalendarCubit(this.repo) : super(CalendarState(selectedDate: DateTime.now()));

  Future<void> loadAppointments(DateTime date) async {
    emit(state.copyWith(status: CalendarStatus.loading, selectedDate: date));
    try {
      final appointments = await repo.getAppointments(date);
      emit(
        state.copyWith(
          status: CalendarStatus.success,
          appointments: appointments,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CalendarStatus.failure, error: e.toString()));
    }
  }

  void selectDate(DateTime date) {
    loadAppointments(date);
  }

  Future<void> deleteAppointment(String id) async {
    try {
      await repo.deleteAppointment(id);
      final updated = List.of(state.appointments)
        ..removeWhere((a) => a.id == id);
      emit(state.copyWith(appointments: updated));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
