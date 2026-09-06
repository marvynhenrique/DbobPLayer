import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/connection_method_screen.dart';
import '../features/auth/presentation/login_password_screen.dart';
import '../features/auth/presentation/sync_screen.dart';
import '../features/auth/presentation/xtream_codes_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

class DBobPlayerApp extends StatelessWidget {
  const DBobPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DBob Player',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        ConnectionMethodScreen.routeName: (_) => const ConnectionMethodScreen(),
        LoginPasswordScreen.routeName: (_) => const LoginPasswordScreen(),
        XtreamCodesScreen.routeName: (_) => const XtreamCodesScreen(),
        SyncScreen.routeName: (_) => const SyncScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
      },
    );
  }
}
