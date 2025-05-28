import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/onboarding_screen.dart';
import '../features/dashboard/dashboard_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
