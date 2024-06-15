import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/utils/translator.dart';
import 'package:hamrah_salamat/Features/profile/providers/profile_provider.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/local_notification_controller.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';
import 'package:hamrah_salamat/Features/targeting/screens/active_targets_section.dart';
import 'package:hamrah_salamat/Features/targeting/screens/completed_targets_section.dart';
import 'package:hamrah_salamat/Features/targeting/screens/select_category_of_target_screen.dart';

class TargetsScreen extends StatefulWidget {
  const TargetsScreen({super.key});

  @override
  State<TargetsScreen> createState() => _TargetsScreenState();
}

class _TargetsScreenState extends State<TargetsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late LocalNotificationController _localNotificationController;
  late TargetsProvider _targetsProvider;
  bool showFloatingActionButton = false;

  @override
  void initState() {
    _localNotificationController = LocalNotificationController();
    _localNotificationController.initializeNotifications();

    _targetsProvider = Provider.of<TargetsProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      _targetsProvider.getTargets(context: context).then((_) {
        setState(() {
          checkStatusOfFAB(targetsProvider: _targetsProvider, index: _tabController.index);
        });

        if (_targetsProvider.activeTargets != null) {
          for (Target target in _targetsProvider.activeTargets!) {
            if (target.reminders != null) {
              for (Reminder reminder in target.reminders!) {
                _localNotificationController.scheduleWeeklyNotifications(
                  fullname: Provider.of<ProfileProvider>(context, listen: false).user?.fullname ?? 'کاربر',
                  day: Translation.translator[reminder.day],
                  times: reminder.times!,
                );
              }
            }
          }
        }
      });
    });

    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: showFloatingActionButton
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.pushNamed(context, SelectCategoryOfTargetScreen.routeName);
              },
              tooltip: 'Add',
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: linearGradient(context: context),
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.tertiary,
                ), // Add your icon
              ),
            )
          : null,
      floatingActionButtonLocation: CustomFabLocation(offsetX: width / 3 + 10, offsetY: height / 9),
      body: Column(
        children: [
          Ink(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              onTap: (value) {
                setState(() {
                  checkStatusOfFAB(targetsProvider: _targetsProvider, index: value);
                });
              },
              labelColor: Theme.of(context).colorScheme.tertiary,
              unselectedLabelColor: Theme.of(context).scaffoldBackgroundColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    'اهداف فعال',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Tab(
                  child: Text(
                    'اهداف تکمیل شده',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ],
              controller: _tabController,
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ActiveTargetsSection(),
                ColmpletedTargetsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkStatusOfFAB({
    required TargetsProvider targetsProvider,
    required int index,
  }) {
    if (index == 0) {
      if (targetsProvider.activeTargets?.isNotEmpty ?? false) {
        showFloatingActionButton = true;
      } else {
        showFloatingActionButton = false;
      }
    } else if (index == 1) {
      if (targetsProvider.completedTargets?.isNotEmpty ?? false) {
        showFloatingActionButton = true;
      } else {
        showFloatingActionButton = false;
      }
    }
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  final double offsetX;
  final double offsetY;

  CustomFabLocation({this.offsetX = 0, this.offsetY = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double floatingActionButtonX = scaffoldGeometry.scaffoldSize.width / 2 - 28 + offsetX; // Adjust 28 according to the size of your FAB
    final double floatingActionButtonY = scaffoldGeometry.contentBottom - 70 - offsetY; // Adjust 70 according to your desired vertical position
    return Offset(floatingActionButtonX, floatingActionButtonY);
  }

  @override
  String toString() => 'CustomFabLocation';
}
