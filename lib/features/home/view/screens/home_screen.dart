import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:beauty_salon/core/utils/app_colors.dart';
import 'package:beauty_salon/features/home/cubit/home_cubit.dart';
import 'package:beauty_salon/features/home/cubit/home_state.dart';
import 'package:beauty_salon/features/home/repo/home_repo.dart';
import 'package:beauty_salon/features/home/service/home_service.dart';
import 'package:beauty_salon/features/home/view/widgets/schedule_card.dart';

import 'package:beauty_salon/core/utils/route_names.dart'; // uses Routes.home / calendar / clients / profile

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Home tab

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(HomeRepo(HomeService()))..load(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8F7),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF6F8F7),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          title: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final title = state.dateTitle.isEmpty ? 'Today' : state.dateTitle;
              return Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().refresh(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeLoadStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == HomeLoadStatus.failure) {
                return Center(
                  child: Text(state.error ?? 'Something went wrong'),
                );
              }

              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  // Top summary cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _SummaryCard(
                          title: 'Total Appointments',
                          value: state.total.toString(),
                        ),
                        const SizedBox(width: 12),
                        _SummaryCard(
                          title: 'Completed',
                          value: state.completed.toString(),
                          valueColor: const Color(0xFF2ECC71),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _BigPendingCard(pending: state.pending),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Today's Schedule",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  ...state.schedules.map((e) => ScheduleCard(item: e)).toList(),
                  const SizedBox(height: 100),
                ],
              );
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mint,
          onPressed: () {
            context.go(Routes.createAppointment);
          }, // TODO: add-appointment
          child: const Icon(Icons.add, color: Colors.black, size: 30),
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.mint,
          unselectedItemColor: Colors.black38,
          onTap: (i) {
            setState(() => _currentIndex = i);
            switch (i) {
              case 0:
                context.go(Routes.home);
                break;
              case 1:
                context.go(Routes.calendar);
                break;
              case 2:
                context.go(Routes.clients);
                break;
              case 3:
                context.go(Routes.profile);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: 'Clients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  const _SummaryCard({
    required this.title,
    required this.value,
    this.valueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 92,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigPendingCard extends StatelessWidget {
  final int pending;
  const _BigPendingCard({required this.pending});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pending',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const Spacer(),
          Text(
            pending.toString(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFA000),
            ),
          ),
        ],
      ),
    );
  }
}
