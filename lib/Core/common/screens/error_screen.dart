import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';

class ErrorScreen extends StatelessWidget {
  static const String routeName = '/error_screen';

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/error.json'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'متأسفانه خطایی در بارگزاری این صفحه رخ داده است، لطفا ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Button(
              onPressed: () {
                Navigator.pushNamed(context, RootScreens.routeName);
              },
              borderRadius: BorderRadius.circular(30),
              child: Text(
                'بازگشت به خانه',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
