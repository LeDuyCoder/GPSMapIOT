import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpsmapiot/feature/splash/bloc/splash_bloc.dart';
import 'package:gpsmapiot/feature/splash/view/splash_page.dart';

class AppRouter {
  // ====== Route names ======
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';

  // ====== Generate route ======
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashBloc(),
            child: SplashPage(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  // ====== Error route ======
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('404 - Page not found'),
        ),
      ),
    );
  }
}