import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Features/root/providers/root_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late RootProvider _rootProvider;
  bool _isVisible = false;
  Timer? timer;

  @override
  void initState() {
    _rootProvider = Provider.of<RootProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 2)).then((_) {
      _rootProvider.checkUserStatus(context: context);
    });

    timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _isVisible = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: height / 10),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: _isVisible ? width - 150 : 0,
            height: _isVisible ? width - 150 : 0,
            child: Image.asset(
              'assets/images/icon/splash_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
