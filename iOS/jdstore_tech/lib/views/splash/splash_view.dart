import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_tech/views/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3, milliseconds: 500), (timer) {
      timer.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeView()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
