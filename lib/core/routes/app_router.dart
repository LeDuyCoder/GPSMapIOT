import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpsmapiot/core/services/usb_service.dart';
import 'package:gpsmapiot/feature/splash/bloc/splash_bloc.dart';
import 'package:gpsmapiot/feature/splash/bloc/splash_event.dart';
import 'package:gpsmapiot/feature/splash/view/splash_page.dart';
import 'package:gpsmapiot/feature/usb/bloc/usb_bloc.dart';
import 'package:gpsmapiot/feature/usb/presentation/pages/usb_page.dart';

class AppRouter {
  // ====== Route names ======
  static const String splash = '/';
  static const String usb = '/usb';

  // ====== Generate route ======
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashBloc()..add(SplashStarted()),
            child: SplashPage(),
          ),
        );
      case usb:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => UsbBloc(UsbService()),
            child: UsbPage()
          ),
        );
        break;

      default:
        return _errorRoute();
    }
  }

  // ====== Error route ======
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('404 - Page not found'))),
    );
  }
}
