import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/constants/data/days_of_week.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/loading_data.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/diet_plan.dart';
import 'package:hamrah_salamat/Features/diet_planning/controllers/diet_plan_controller.dart';
import 'package:hamrah_salamat/Features/diet_planning/providers/diet_plan_provider.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/date_box.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/meal_expansion_tile.dart';

class DietPlanTrackingScreen extends StatefulWidget {
  static const String routeName = '/diet_plan_tracking_screen';

  const DietPlanTrackingScreen({super.key});

  @override
  State<DietPlanTrackingScreen> createState() => _DietPlanTrackingScreenState();
}

class _DietPlanTrackingScreenState extends State<DietPlanTrackingScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late DietPlanProvider _dietPlanProvider;
  late DietPlanController _dietPlanController;

  List<String> nextDays = [];
  List<Map<String, dynamic>> dates = [];

  @override
  void initState() {
    _dietPlanProvider = Provider.of<DietPlanProvider>(context, listen: false);
    _dietPlanController = DietPlanController();

    Jalali start = Jalali(
      int.parse(_dietPlanProvider.dietPlan!.startDate!.split('/')[0]),
      int.parse(_dietPlanProvider.dietPlan!.startDate!.split('/')[1]),
      int.parse(_dietPlanProvider.dietPlan!.startDate!.split('/')[2]),
    );
    nextDays = _dietPlanController.getNextDays(
      daysOfWeek[start.weekDay - 1],
    );

    _tabController = TabController(
      length: 7,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    dates = <Map<String, dynamic>>[
      {
        "title": "شروع",
        "date": _dietPlanProvider.dietPlan!.startDate,
        "color": Theme.of(context).primaryColor.withOpacity(0.6),
      },
      {
        "title": "پایان",
        "date": _dietPlanProvider.dietPlan!.endDate,
        "color": Theme.of(context).colorScheme.error.withOpacity(0.6),
      },
    ];

    return Scaffold(
      bottomSheet: Padding(
        padding: edgeInsetsGeometryOfScreens(context: context),
        child: Button(
          width: width,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.error,
              Theme.of(context).colorScheme.error.withOpacity(0.7),
            ],
          ),
          onPressed: () {
            if (_dietPlanProvider.status != AppState.loading) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/common/delete.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 50),
                        child: Text(
                          'آیا مطمئن هستید میخواهید برنامه غذایی خود را حذف کنید؟',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 50),
                        child: Button(
                          width: width,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.error,
                              Theme.of(context).colorScheme.error.withOpacity(0.7),
                            ],
                          ),
                          onPressed: () {
                            _dietPlanProvider.deleteDietPlan(
                              context: context,
                              startDate: _dietPlanProvider.dietPlan!.startDate!,
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            'حذف',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          child: Text(
            'حذف برنامه',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
      body: Consumer<DietPlanProvider>(
        builder: (context, dietPlanProvider, _) {
          if (dietPlanProvider.status == AppState.loading || dietPlanProvider.dietPlan == null) {
            return const LoadingData();
          }
          void updateDietPLan() {
            dietPlanProvider.updateDietPlan(
              context: context,
              dietPlan: DietPlan(
                dietPlanDays: dietPlanProvider.dietPlan!.dietPlanDays!,
                editable: dietPlanProvider.dietPlan!.editable,
                startDate: dietPlanProvider.dietPlan!.startDate,
                endDate: dietPlanProvider.dietPlan!.endDate,
              ),
            );
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          dates.length,
                          (index) => DateBox(
                            title: dates[index]['title'],
                            date: dates[index]['date'],
                            color: dates[index]['color'],
                          ),
                        ),
                      ),
                    ),
                    Ink(
                      color: Theme.of(context).colorScheme.surface,
                      child: TabBar(
                        tabAlignment: TabAlignment.start,
                        labelColor: Theme.of(context).colorScheme.tertiary,
                        unselectedLabelColor: Theme.of(context).scaffoldBackgroundColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        tabs: nextDays
                            .map(
                              (day) => Tab(child: Text(day)),
                            )
                            .toList(),
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    _tabController.length,
                    (idx) {
                      DietPlanDay dietPlanDay = dietPlanProvider.dietPlan!.dietPlanDays![idx];

                      return Padding(
                        padding: edgeInsetsGeometryOfScreens(context: context),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              dietPlanDay.meals?.length ?? 0,
                              (index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: height / 50),
                                  child: MealExpansionTile(
                                    meal: dietPlanDay.meals![index],
                                    editable: dietPlanProvider.dietPlan!.editable == 0 ? false : true,
                                    enable: true,
                                    dietPlanType: null,
                                    onPressedSaveEdible: (edible) {
                                      setState(() {
                                        dietPlanDay.meals?[index].edibles?.add(edible);
                                      });
                                      updateDietPLan();
                                    },
                                    onPressedChangeStatusOfMeal: (status) {
                                      dietPlanProvider.dietPlan!.dietPlanDays![idx].meals?[index].status = status;
                                      updateDietPLan();
                                    },
                                    onPressedDeleteEdible: (edible) {
                                      setState(() {
                                        dietPlanDay.meals?[index].edibles?.remove(edible);
                                      });
                                      updateDietPLan();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
