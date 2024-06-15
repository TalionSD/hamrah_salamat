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

class ViewDietPlanScreen extends StatefulWidget {
  static const String routeName = '/view_diet_plan_screen';
  final TypeOfDietPlaning? typeOfDietPlaning;
  final Map<String, dynamic>? template;

  const ViewDietPlanScreen({
    super.key,
    this.typeOfDietPlaning,
    this.template,
  });

  @override
  State<ViewDietPlanScreen> createState() => _ViewDietPlanScreenState();
}

class _ViewDietPlanScreenState extends State<ViewDietPlanScreen> with TickerProviderStateMixin {
  TypeOfDietPlaning? typeOfDietPlaning;

  late DietPlanProvider _dietPlanProvider;
  late DietPlanController _dietPlanController;
  late final TabController _tabController;

  List<DietPlanDay> dietPlanDays = [];

  List<Map<String, dynamic>> dates = [];

  String today = '';
  List<String> nextDays = [];
  Jalali todayDate = Jalali.now();
  String startdDate = '';
  String endDate = '';

  @override
  void initState() {
    _tabController = TabController(
      length: 7,
      vsync: this,
    );
    _dietPlanProvider = Provider.of(context, listen: false);
    _dietPlanController = DietPlanController();

    Jalali end = todayDate.addDays(7);
    startdDate = '${todayDate.year}/${todayDate.month}/${todayDate.day}';
    endDate = '${end.year}/${end.month}/${end.day}';
    today = daysOfWeek[todayDate.weekDay - 1];
    nextDays = _dietPlanController.getNextDays(today);

    typeOfDietPlaning = widget.typeOfDietPlaning;

    if (typeOfDietPlaning == TypeOfDietPlaning.template) {
      dietPlanDays = _dietPlanProvider.dietPlanTemplateDays!;
    } else if (typeOfDietPlaning == TypeOfDietPlaning.custom) {
      dietPlanDays = List.generate(
        7,
        (index) => DietPlanDay(
          title: nextDays[index],
          meals: [
            Meal(name: 'صبحانه', edibles: []),
            Meal(name: 'ناهار', edibles: []),
            Meal(name: 'شام', edibles: []),
            Meal(name: 'میان وعده', edibles: []),
          ],
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    dates = <Map<String, dynamic>>[
      {
        "title": "شروع",
        "date": startdDate,
        "color": Theme.of(context).primaryColor.withOpacity(0.6),
      },
      {
        "title": "پایان",
        "date": endDate,
        "color": Theme.of(context).colorScheme.error.withOpacity(0.6),
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Padding(
        padding: edgeInsetsGeometryOfScreens(context: context),
        child: _dietPlanProvider.dietPlan == null
            ? Button(
                width: width,
                onPressed: () {
                  if (_dietPlanProvider.status != AppState.loading) {
                    if (_dietPlanController.checkEdibles(dietPlanDays: dietPlanDays)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/images/diet_planning/null_edible.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height / 50),
                                child: Text(
                                  'برای بعضی از روزها خوراکی اضافه نشده است! مطمئن هستید میخواهید برنامه را ثبت کنید؟',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height / 50),
                                child: Button(
                                  width: width,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).colorScheme.surface,
                                    ],
                                  ),
                                  child: Text(
                                    'تکمیل برنامه',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height / 50),
                                child: Button(
                                  width: width,
                                  onPressed: () {
                                    _dietPlanProvider.createDietPlan(
                                      context: context,
                                      dietPlan: DietPlan(
                                        dietPlanDays: dietPlanDays,
                                        editable: typeOfDietPlaning == TypeOfDietPlaning.template ? 0 : 1,
                                        startDate: dates[0]['date'],
                                        endDate: dates[1]['date'],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'ثبت',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      _dietPlanProvider.createDietPlan(
                        context: context,
                        dietPlan: DietPlan(
                          dietPlanDays: dietPlanDays,
                          editable: typeOfDietPlaning == TypeOfDietPlaning.template ? 0 : 1,
                          startDate: dates[0]['date'],
                          endDate: dates[1]['date'],
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'ثبت برنامه',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            : Container(
                width: width,
                height: height / 12,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.error,
                ),
                child: Text(
                  'شما یک برنامه غذایی فعال دارید! ابتدا آن را تکمیل یا حذف کنید، سپس اقدام به ساخت برنامه غذایی جدید بکنید',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
      body: typeOfDietPlaning == TypeOfDietPlaning.template
          ? Consumer<DietPlanProvider>(
              builder: (context, dietPlanProvider, _) {
                if (dietPlanProvider.status == AppState.loading || dietPlanProvider.dietPlanTemplateDays == null) {
                  return const LoadingData();
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
                        children: List.generate(_tabController.length, (index) {
                          return Padding(
                            padding: edgeInsetsGeometryOfScreens(context: context),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  dietPlanDays[index].meals?.length ?? 0,
                                  (idx) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: height / 50),
                                      child: MealExpansionTile(
                                        meal: dietPlanDays[index].meals![idx],
                                        editable: false,
                                        enable: false,
                                        dietPlanType: typeOfDietPlaning,
                                        onPressedSaveEdible: (edible) {
                                          setState(() {
                                            dietPlanDays[index].meals?[idx].edibles?.add(edible);
                                          });
                                        },
                                        onPressedDeleteEdible: (edible) {
                                          setState(() {
                                            dietPlanDays[index].meals?[idx].edibles?.remove(edible);
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            )
          : Column(
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
                      TabBar(
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
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: List.generate(_tabController.length, (index) {
                      return Padding(
                        padding: edgeInsetsGeometryOfScreens(context: context),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              dietPlanDays[index].meals?.length ?? 0,
                              (idx) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: height / 50),
                                  child: MealExpansionTile(
                                    meal: dietPlanDays[index].meals![idx],
                                    editable: true,
                                    enable: false,
                                    dietPlanType: typeOfDietPlaning,
                                    onPressedSaveEdible: (edible) {
                                      setState(() {
                                        dietPlanDays[index].meals?[idx].edibles?.add(edible);
                                      });
                                    },
                                    onPressedDeleteEdible: (edible) {
                                      setState(() {
                                        dietPlanDays[index].meals?[idx].edibles?.remove(edible);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}
