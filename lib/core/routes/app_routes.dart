import 'package:beauty_salon/features/appointments/view/screens/create_appointment_screen.dart';
import 'package:beauty_salon/features/calendar/view/screens/calendar_screen.dart';
import 'package:beauty_salon/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:beauty_salon/core/utils/route_names.dart';

import 'package:beauty_salon/features/authentication/view/screens/forgot_password_screen.dart';
import 'package:beauty_salon/features/authentication/view/screens/login_screen.dart';
import 'package:beauty_salon/features/authentication/view/screens/reset_password_screen.dart';
import 'package:beauty_salon/features/authentication/view/screens/signup_screen.dart';
import 'package:beauty_salon/features/authentication/view/screens/welcome_screen.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      transitionGoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => const LoginScreen(),
      ),
      transitionGoRoute(
        path: Routes.welcome,
        pageBuilder: (context, state) => const WelcomePage(),
      ),
      transitionGoRoute(
        path: Routes.signup,
        pageBuilder: (context, state) => const SignUpScreen(),
      ),
      transitionGoRoute(
        path: Routes.forgotPassword,
        pageBuilder: (context, state) => const ForgotPasswordScreen(),
      ),
      transitionGoRoute(
        path: Routes.resetPassword,
        pageBuilder: (context, state) => const ResetPasswordScreen(),
      ),
      transitionGoRoute(
        path: Routes.home,
        pageBuilder: (context, state) => const HomeScreen(),
      ),
      transitionGoRoute(
        path: Routes.calendar,
        pageBuilder: (context, state) => const CalendarScreen(),
      ),
      transitionGoRoute(
        path: Routes.createAppointment,
        pageBuilder: (context, state) => const CreateAppointmentScreen(),
      ),
    ],
  );

  static void back(BuildContext context, {dynamic result}) {
    try {
      context.pop(result);
    } catch (e) {
      if (e is GoError) {
        if (e.message == 'There is nothing to pop') {
          replace(context, Routes.splash);
        }
      }
    }
  }

  static Future push<T>(
    BuildContext context,
    String page, {
    T? arguments,
  }) async {
    return await context.push(page, extra: arguments);
  }

  static void replace<T>(
    BuildContext context,
    String page, {
    T? arguments,
  }) async {
    context.replace(page, extra: arguments);
  }

  static void go<T>(BuildContext context, String page, {T? arguments}) {
    context.go(page, extra: arguments);
  }
}

GoRoute transitionGoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 300),
      child: pageBuilder(context, state),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeIn).animate(animation),
          child: child,
        );
      },
    ),
  );
}
