import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:beauty_salon/core/utils/route_names.dart';
import 'package:beauty_salon/features/calendar/cubit/calendar_cubit.dart';
import 'package:beauty_salon/features/calendar/cubit/calendar_state.dart';
import 'package:beauty_salon/features/calendar/repo/calendar_repo.dart';
import 'package:beauty_salon/features/calendar/service/calendar_service.dart';
import 'package:beauty_salon/features/calendar/view/widgets/appointment_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    const mint = Color(0xFFAEC6C1);
    const lightGray = Color(0xFFF6F8F7);

    return BlocProvider(
      create: (_) =>
          CalendarCubit(CalendarRepo(CalendarService()))
            ..loadAppointments(DateTime.now()),
      child: Scaffold(
        backgroundColor: lightGray,
        appBar: AppBar(
          backgroundColor: lightGray,
          elevation: 0,
          title: const Text(
            "Schedule",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            if (state.status == CalendarStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == CalendarStatus.failure) {
              return Center(child: Text(state.error ?? "Error loading data"));
            }

            final formattedMonth = DateFormat(
              'MMMM yyyy',
            ).format(state.selectedDate);
            final formattedDay = DateFormat(
              'EEEE, MMMM d',
            ).format(state.selectedDate);

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    formattedMonth,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                _buildCalendarRow(context, state.selectedDate, mint),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    formattedDay,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ...state.appointments.map(
                  (e) => AppointmentCard(
                    item: e,
                    onDelete: () =>
                        context.read<CalendarCubit>().deleteAppointment(e.id),
                    onUpdate: () {
                      context.go(Routes.createAppointment);
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: mint,
          onPressed: () => context.go(Routes.createAppointment),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildCalendarRow(
    BuildContext context,
    DateTime selectedDate,
    Color mint,
  ) {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    final days = List.generate(7, (i) {
      final day = firstDayOfWeek.add(Duration(days: i));
      final isSelected = DateUtils.isSameDay(day, selectedDate);

      return GestureDetector(
        onTap: () => context.read<CalendarCubit>().selectDate(day),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: isSelected ? mint.withOpacity(0.4) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                DateFormat('E').format(day),
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Text(
                DateFormat('d').format(day),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.black : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: days),
    );
  }
}
