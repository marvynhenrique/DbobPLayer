import 'dart:async';

import 'package:flutter/material.dart';

import '../../../services/session_storage.dart';
import '../../../shared/widgets/dbob_logo.dart';
import '../../auth/presentation/connection_method_screen.dart';
import '../../home/presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;
  final _sessionStorage = SessionStorage();

  @override
  void initState() {
    super.initState();

    _navigationTimer = Timer(const Duration(milliseconds: 900), () async {
      if (!mounted) return;

      final session = await _sessionStorage.load();

      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed(
        session == null ? ConnectionMethodScreen.routeName : HomeScreen.routeName,
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DBobLogo(size: 38),
            SizedBox(height: 18),
            CircularProgressIndicator(),
            SizedBox(height: 18),
            Text('Preparando experiência de streaming...'),
          ],
        ),
      ),
    );
  }
}
