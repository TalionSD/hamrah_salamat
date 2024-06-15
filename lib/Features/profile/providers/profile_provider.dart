// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';
import 'package:hamrah_salamat/Core/configs/routes.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Database/database.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';

class ProfileProvider with ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  ProfileProvider() {
    initializeData();
  }

  initializeData() {
    _databaseHelper = DatabaseHelper();
  }

  AppState _status = AppState.stable;
  AppState get status => _status;

  User? _user;
  User? get user => _user;

  Future<User?> getUser({
    required BuildContext context,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      Map<String, dynamic> result = await _databaseHelper.queryRowUser();
      _user = User.fromJson(result);


      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
    return _user;
  }

  Future<User?> updateProfile({
    required BuildContext context,
    required User user,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      await _databaseHelper.updateUser({
        "image_url": user.imageUrl,
      }).then((_) {
        Navigator.pushReplacementNamed(
          context,
          RootScreens.routeName,
          arguments: RootScreenItems.profile,
        );
      });

      showSnackBar(
        context,
        message: "پروفایل شما با موفقیت ویرایش شد",
        snackbarType: SnackBarType.success,
      );

      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
    return _user;
  }
}
