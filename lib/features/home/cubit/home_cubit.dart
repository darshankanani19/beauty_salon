import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beauty_salon/features/home/repo/home_repo.dart';
import 'package:beauty_salon/features/home/models/home_schedule_model.dart';
import 'home_state.dart';
import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  HomeCubit(this.repo) : super(const HomeState());

  Future<void> load() async {
    emit(state.copyWith(status: HomeLoadStatus.loading));

    try {
      final today = DateFormat("EEE, MMM d").format(DateTime.now());
      final list = await repo.getTodaySchedules();

      final completed = list
          .where((e) => e.status == AppointmentStatus.completed)
          .length;
      final pending = list.length - completed;

      emit(
        state.copyWith(
          status: HomeLoadStatus.success,
          schedules: list,
          total: list.length,
          completed: completed,
          pending: pending,
          dateTitle: "Today, $today",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeLoadStatus.failure, error: e.toString()));
    }
  }

  Future<void> refresh() => load();
}
