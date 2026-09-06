import 'dart:async';

import 'package:flutter/material.dart';

import '../../../shared/widgets/dbob_logo.dart';
import '../../auth/presentation/connection_method_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _navigationTimer = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed(
        ConnectionMethodScreen.routeName,
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
