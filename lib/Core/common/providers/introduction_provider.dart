// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/configs/routes.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Database/database.dart';

class IntroductionProvider with ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  IntroductionProvider() {
    initializeData();
  }

  initializeData() {
    _databaseHelper = DatabaseHelper();
  }

  AppState _status = AppState.stable;
  AppState get status => _status;

  bool? _loginIntroductionHasViewed;
  bool? get loginIntroductionHasViewed => _loginIntroductionHasViewed;

  bool? _dietPlanningIntroductionHasViewed;
  bool? get dietPlanningIntroductionHasViewed => _dietPlanningIntroductionHasViewed;

  bool? _targetingIntroductionHasViewed;
  bool? get targetingIntroductionHasViewed => _targetingIntroductionHasViewed;

  Future<void> setViewForIntroductionScreens({
    required BuildContext context,
    required IntroductionScreens introductionScreen,
    required int viewed,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      String tableColumn = "";
      if (introductionScreen == IntroductionScreens.login) {
        tableColumn = "login";
      } else if (introductionScreen == IntroductionScreens.dietPlanning) {
        tableColumn = "diet_planning";
      } else if (introductionScreen == IntroductionScreens.targeting) {
        tableColumn = "targeting";
      } else if (introductionScreen == IntroductionScreens.intro) {
        tableColumn = "intro";
      }

      _databaseHelper.insertIntoIntroductionScrenn({
        tableColumn: viewed,
      });

      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  Future<Map<String, bool?>> getViewForIntroductionScreens({
    required BuildContext context,
    required IntroductionScreens introductionScreen,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      Map<String, dynamic> result = await _databaseHelper.queryRowIntroductionScrenn();

      if (introductionScreen == IntroductionScreens.login) {
        _loginIntroductionHasViewed = result['login'] == 0 ? false : true;
      } else if (introductionScreen == IntroductionScreens.dietPlanning) {
        _dietPlanningIntroductionHasViewed = result['diet_planning'] == 0 ? false : true;
      } else if (introductionScreen == IntroductionScreens.dietPlanning) {
        _targetingIntroductionHasViewed = result['targeting'] == 0 ? false : true;
      }

      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }

    return {
      "login": _loginIntroductionHasViewed,
      "diet_planning": _dietPlanningIntroductionHasViewed,
      "targeting": _targetingIntroductionHasViewed,
    };
  }
}
