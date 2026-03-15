import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';
import 'presentation/state/login_provider.dart';
import 'presentation/state/signup_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/signup_screen.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/medical_history_screen.dart';
import 'presentation/state/medical_history_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealthCareApp());
}

class HealthCareApp extends StatelessWidget {
  const HealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _generateRoute,
    );
  }

  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginStateManager(child: LoginScreen()),
        );

      case AppRoutes.signup:
        return _swapPageRoute(const SignupStateManager(child: SignupScreen()));

      case AppRoutes.dashboard:
        final initialIndex =
            settings.arguments is int ? settings.arguments as int : 0;
        return _swapPageRoute(DashboardScreen(initialIndex: initialIndex));
      case AppRoutes.medicalHistory:
        return _swapPageRoute(
          const MedicalHistoryStateManager(child: MedicalHistoryScreen()),
        );

      case AppRoutes.insuranceDetails:
        return _swapPageRoute(
          const _PlaceholderScreen(title: 'Insurance Details'),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => _PlaceholderScreen(title: 'Not Found: ${settings.name}'),
        );
    }
  }
}


PageRouteBuilder<dynamic> _swapPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 420),
    reverseTransitionDuration: const Duration(milliseconds: 380),
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      final slideIn = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      final slideOut = Tween<Offset>(
        begin: Offset.zero,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInCubic));

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
}

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
