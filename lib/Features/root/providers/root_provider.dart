// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:hamrah_salamat/Core/configs/routes.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Database/database.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';
import 'package:hamrah_salamat/Features/root/screens/intro_screens.dart';
import 'package:hamrah_salamat/Features/root/screens/login_screen.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';

class RootProvider with ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  RootProvider() {
    initializeData();
  }

  initializeData() {
    _databaseHelper = DatabaseHelper();
  }

  AppState _status = AppState.stable;
  AppState get status => _status;

  User? _user;
  User? get user => _user;

  Future<void> createUser({
    required BuildContext context,
    required User user,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      await _databaseHelper.insertIntoUser({
        'fullname': user.fullname,
        'image_url': user.imageUrl,
      }).then((_) {
        Navigator.pushReplacementNamed(
          context,
          RootScreens.routeName,
        );
      });

      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  Future<void> checkUserStatus({
    required BuildContext context,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      _databaseHelper.initializeDatabase().then((_) async {
        await _databaseHelper.queryRowIntroductionScrenn().then((value) async {
          if (value['intro'] == 1) {
            await _databaseHelper.queryRowUser().then((user) async {
              if (user['fullname'] != null) {
                await _databaseHelper.queryRowDietPlan().then((dietPlan) {
                  if (dietPlan.isNotEmpty) {
                    Jalali date = Jalali.now().addDays(1);
                    String todayDate = '${date.year}/${date.month}/${date.day}';

                    if (dietPlan['end_date'] == todayDate) {
                      _databaseHelper.deleteFromDietPlan(dietPlan['start_date']);
                    }
                  }
                }).then((_) {
                  Navigator.pushNamed(context, RootScreens.routeName);
                });
              } else {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              }
            });
          } else {
            Navigator.pushReplacementNamed(context, IntroScreens.routeName);
          }
        });
      });

      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }
}
