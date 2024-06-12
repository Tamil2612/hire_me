import 'package:go_router/go_router.dart';

import '../ui/home/home_screen.dart';
import '../ui/intro/onboarding_screen.dart';
import '../ui/login/login_screen.dart';
import '../ui/register/register_screen.dart';

GoRouter router(bool showIntro, bool loginDone) {
  return GoRouter(
    initialLocation: showIntro
        ? "/intro"
        : loginDone
            ? "/home"
            : "/login",
    routes: <RouteBase>[
      GoRoute(
        name: "/intro",
        path: "/intro",
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        name: "/register",
        path: "/register",
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        name: "/login",
        path: "/login",
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: "/home",
        path: "/home",
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
