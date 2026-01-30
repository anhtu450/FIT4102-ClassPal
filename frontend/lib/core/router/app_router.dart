import 'package:go_router/go_router.dart';
import 'package:classpal/features/auth/login_screen.dart';
import 'package:classpal/features/dashboard/presentation/dashboard_screen.dart';
import 'package:classpal/features/duty_roster/duty_roster_screen.dart';
import 'package:classpal/features/asset_manager/asset_manager_screen.dart';
import 'package:classpal/features/event_signup/event_signup_screen.dart';
import 'package:classpal/features/class_fund/class_fund_screen.dart';

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
  ],
);
