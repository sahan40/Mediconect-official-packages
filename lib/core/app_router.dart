import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/dashboard_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/medical_history_screen.dart';
import '../presentation/screens/signup_screen.dart';
import '../presentation/screens/splash_screen.dart';
import '../presentation/state/login_provider.dart';
import '../presentation/state/medical_history_provider.dart';
import '../presentation/state/signup_provider.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: <GoRoute>[
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder:
          (context, state) => const LoginStateManager(child: LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder:
          (context, state) => const SignupStateManager(child: SignupScreen()),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      pageBuilder: (context, state) {
        final tabQuery = state.uri.queryParameters['tab'];
        final initialIndex = int.tryParse(tabQuery ?? '') ?? 0;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 420),
          reverseTransitionDuration: const Duration(milliseconds: 380),
          child: DashboardScreen(initialIndex: initialIndex),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideIn = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

            final slideOut = Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-0.0, 0.0),
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInCubic),
            );

            final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
              ),
            );

            return SlideTransition(
              position: slideOut,
              child: FadeTransition(
                opacity: fadeOut,
                child: SlideTransition(position: slideIn, child: child),
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: AppRoutes.medicalHistory,
      builder:
          (context, state) =>
              const MedicalHistoryStateManager(child: MedicalHistoryScreen()),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder:
          (context, state) =>
              const _PlaceholderScreen(title: 'Forgot Password'),
    ),
    GoRoute(
      path: AppRoutes.insuranceDetails,
      builder:
          (context, state) =>
              const _PlaceholderScreen(title: 'Insurance Details'),
    ),
  ],
  errorBuilder:
      (context, state) => _PlaceholderScreen(title: 'Not Found: ${state.uri}'),
);

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title\n(Coming soon)',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
