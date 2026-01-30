import 'package:go_router/go_router.dart';
import 'package:classpal/features/auth/login_screen.dart';
import 'package:classpal/features/dashboard/presentation/dashboard_screen.dart';
import 'package:classpal/features/dashboard/presentation/task_detail_screen.dart';
import 'package:classpal/features/dashboard/presentation/notification_detail_screen.dart';
import 'package:classpal/features/duty_roster/duty_roster_screen.dart';
import 'package:classpal/features/asset_manager/asset_manager_screen.dart';
import 'package:classpal/features/event_signup/event_signup_screen.dart';
import 'package:classpal/features/class_fund/class_fund_screen.dart';
import 'package:classpal/features/settings/presentation/settings_screen.dart';
import 'package:classpal/features/settings/presentation/profile_screen.dart';
import 'package:classpal/features/settings/presentation/change_password_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/duty-roster',
      builder: (context, state) => const DutyRosterScreen(),
    ),
    GoRoute(
      path: '/asset-manager',
      builder: (context, state) => const AssetManagerScreen(),
    ),
    GoRoute(
      path: '/event-signup',
      builder: (context, state) => const EventSignupScreen(),
    ),
    GoRoute(
      path: '/class-fund',
      builder: (context, state) => const ClassFundScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/task-detail',
      builder: (context, state) {
        final task = state.extra as Map<String, dynamic>;
        return TaskDetailScreen(task: task);
      },
    ),
    GoRoute(
      path: '/notification-detail',
      builder: (context, state) {
        final notification = state.extra as Map<String, dynamic>;
        return NotificationDetailScreen(notification: notification);
      },
    ),
  ],
);
