import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hamrah_salamat/Core/configs/routes.dart';
import 'package:hamrah_salamat/Core/constants/notifier_providers.dart';
import 'package:hamrah_salamat/Core/constants/theme/app_theme.dart';
import 'package:hamrah_salamat/Features/root/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Tehran'));

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(0.9),
                padding: const EdgeInsets.all(0),
              ),
              child: MaterialApp(
                title: 'همراه سلامت',
                theme: theme,
                locale: const Locale('fa', 'IR'), // Persian (Iran)
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('fa', 'IR'),
                ],
                debugShowCheckedModeBanner: false,
                initialRoute: SplashScreen.routeName,
                routes: routes,
                home: const SplashScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
