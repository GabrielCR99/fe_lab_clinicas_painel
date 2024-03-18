import 'dart:async';

import 'package:flutter/material.dart';

final class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

final class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(
      () => Navigator.of(context).pushReplacementNamed<void, void>('/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo_vertical.png'),
      ),
    );
  }
}
