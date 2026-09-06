import 'package:flutter/material.dart';

class DBobLogo extends StatelessWidget {
  const DBobLogo({super.key, this.size = 34});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'DBob '),
          TextSpan(
            text: 'Player',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        color: Colors.white,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.8,
      ),
    );
  }
}
