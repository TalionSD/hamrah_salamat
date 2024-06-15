// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';
import 'package:hamrah_salamat/Core/configs/routes.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Database/database.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/create_target_controller.dart';

class TargetsProvider extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;
  late TargetingController _targetingController;

  TargetsProvider() {
    initializeData();
  }

  initializeData() {
    _databaseHelper = DatabaseHelper();
    _targetingController = TargetingController();
  }

  AppState _status = AppState.stable;
  AppState get status => _status;

  Target? _target;
  Target? get target => _target;

  List<Target>? _activeTargets;
  List<Target>? get activeTargets => _activeTargets;

  List<Target>? _completedTargets;
  List<Target>? get completedTargets => _completedTargets;

  Target? setValueForTarget({
    required Target target,
  }) {
    _target = target;
    notifyListeners();

    return _target;
  }

  // Create a target and navigate to TargetsScreen for watch targets
  Future<void> createTarget({
    required BuildContext context,
    required Target target,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      await _databaseHelper.insertIntoTargets({
        'title': target.title,
        'image_url': target.imageUrl,
        'category': target.category,
        'tags': target.tags,
        'reminders': target.reminders?.map((item) => item.toJson()).toList(),
        'target_days': target.targetDays?.map((item) => item.toJson()).toList(),
        'start_date': target.startDate,
        'end_date': target.endDate,
        'description': target.description,
        'todos': target.todos?.map((item) => item.toJson()).toList(),
      }).then((_) {
        Navigator.pushReplacementNamed(
          context,
          RootScreens.routeName,
          arguments: RootScreenItems.targeting,
        );
      });

      showSnackBar(
        context,
        message: 'هدف شما با موفقیت ایجاد شد',
        snackbarType: SnackBarType.success,
      );

      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  // Update target days and record the daily approach
  Future<void> updateTargetDays({
    required BuildContext context,
    required int id,
    required List<TargetDay> targetDays,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      await _databaseHelper.updateTargetDays(id, targetDays).then((_) {}).then((_) {
        Navigator.pop(context);
      });
      showSnackBar(
        context,
        message: 'یادداشت شما برای امروز با موفقیت ثبت شد',
        snackbarType: SnackBarType.success,
      );
      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  // Update target todos and change state
  Future<void> updateTargetTodos({
    required BuildContext context,
    required int id,
    required List<Todo> todos,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      await _databaseHelper.updateTargetTodos(
        id,
        todos,
      );

      showSnackBar(
        context,
        message: 'هورا! تسک شما با موفقیت تکمیل شد',
        snackbarType: SnackBarType.success,
      );
      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  // Gel all targets from database
  Future<Map<String, List<Target>?>?> getTargets({required BuildContext context}) async {
    try {
      Jalali todayDate = Jalali.now();
      String formattedDate = '${todayDate.year}/${todayDate.month}/${todayDate.day}';

      List<Target> decodeTargetsData = [];
      List<Target> active = [];
      List<Target> completed = [];

      _status = AppState.loading;
      notifyListeners();

      // Query on database
      await _databaseHelper.queryAllRowsTargets().then((result) {
        decodeTargetsData = (result)
            .map(
              (i) => Target.fromJson(i),
            )
            .toList();
      });

      // Check dates of target
      for (Target target in decodeTargetsData) {
        if (_targetingController.isSecondDateNotGreaterThanFirst(target.endDate!, formattedDate)) {
          active.add(target);
        } else {
          completed.add(target);
        }
      }

      _activeTargets = active;
      _completedTargets = completed;

      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }

    return {
      "active_targets": _activeTargets,
      "completed_targets": _completedTargets,
    };
  }
}
