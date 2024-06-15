// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';

import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/create_target_controller.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';
import 'package:hamrah_salamat/Features/targeting/widgets/target_day_widget.dart';

class TargetDetailsScreen extends StatefulWidget {
  static const String routeName = '/target_details_screen';

  const TargetDetailsScreen({
    super.key,
  });

  @override
  State<TargetDetailsScreen> createState() => _TargetDetailsScreenState();
}

class _TargetDetailsScreenState extends State<TargetDetailsScreen> {
  late TargetingController _targetingController;
  late TargetsProvider _targetsProvider;

  Target? target;
  // bool _isExpanded = false;

  Jalali todayDate = Jalali.now();
  String formattedDate = '';

  List<Map<String, dynamic>> noticesOfDates = [];

  @override
  void initState() {
    _targetingController = TargetingController();
    _targetsProvider = Provider.of<TargetsProvider>(context, listen: false);
    formattedDate = '${todayDate.year}/${todayDate.month}/${todayDate.day}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    target = ModalRoute.of(context)!.settings.arguments as Target;

    int passesDaysCount = _targetingController.calculateDifferenceDate(target!.startDate!, formattedDate);
    int leftDaysCounte = _targetingController.calculateDifferenceDate(formattedDate, target!.endDate!);

    noticesOfDates = [
      {
        "title": "امروز",
        "date": formattedDate,
      },
      {
        "title": "رزوهای گذشته",
        "date": "$passesDaysCount روز",
      },
      {
        "title": "روزهای باقی مانده",
        "date": "$leftDaysCounte روز",
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
              child: Column(
                children: [
                  // Container(
                  //   width: 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     gradient: LinearGradient(
                  //       colors: [
                  //         Theme.of(context).colorScheme.error,
                  //         Theme.of(context).colorScheme.onError,
                  //       ],
                  //       begin: Alignment.center,
                  //       end: Alignment.topLeft,
                  //     ),
                  //   ),
                  //   child: Icon(
                  //     Icons.delete_forever_rounded,
                  //     color: Theme.of(context).colorScheme.tertiary,
                  //   ),
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 60),
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image(
                            height: height / 10,
                            image: AssetImage(target!.imageUrl!),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 8,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      target!.title!,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(5),
                                            ),
                                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                                          ),
                                          child: Text(
                                            target!.startDate!,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.vertical(
                                              bottom: Radius.circular(5),
                                            ),
                                            color: Theme.of(context).colorScheme.error.withOpacity(0.8),
                                          ),
                                          child: Text(
                                            target!.endDate!,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'دسته بندی : ',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                  children: [
                                    TextSpan(
                                      text: target!.category!,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  Text(
                                    'تگ ها : ',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                  ),
                                  ...List.generate(
                                    target!.tags!.length,
                                    (index) => Container(
                                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                      margin: const EdgeInsets.only(left: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Text(
                                        target!.tags![index],
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    target!.description!,
                                    // maxLines: _isExpanded ? null : 2,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                  ),
                                  // if (target!.description!.length > 100)
                                  //   GestureDetector(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         _isExpanded = !_isExpanded;
                                  //       });
                                  //     },
                                  //     child: ShaderMask(
                                  //       blendMode: BlendMode.srcATop,
                                  //       shaderCallback: (Rect bounds) {
                                  //         return linearGradient(context: context).createShader(bounds);
                                  //       },
                                  //       child: Row(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Text(
                                  //             _isExpanded ? 'مشاهده کمتر' : 'مشاهده بیشتر',
                                  //           ),
                                  //           Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 40, vertical: height / 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        noticesOfDates.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                noticesOfDates[index]['title'],
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                noticesOfDates[index]['date'],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: edgeInsetsGeometryOfScreens(context: context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (target!.reminders?.isNotEmpty ?? false) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 30,
                        vertical: height / 100,
                      ),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.tertiary,
                        border: Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'یادآورهای هدف',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                  height: height / 50,
                                ),
                                Image(
                                  height: height / 10,
                                  image: const AssetImage('assets/images/targeting/reminder.png'),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.symmetric(vertical: height / 18),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Wrap(
                                children: List.generate(
                                  target!.reminders!.length,
                                  (index) => Container(
                                    margin: EdgeInsets.symmetric(horizontal: width / 50),
                                    padding: const EdgeInsets.only(right: 30, left: 30, bottom: 15),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.tertiary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
                                          ),
                                          child: Text(
                                            target!.reminders![index].day!,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: List.generate(
                                            target!.reminders![index].times!.length,
                                            (idx) => Padding(
                                              padding: const EdgeInsets.only(bottom: 2),
                                              child: Text(
                                                '${target!.reminders![index].times![idx].minute} : ${target!.reminders![index].times![idx].hour}',
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                  ],
                  Text(
                    'مدیریت روزهای هدف 📆',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(
                      target!.targetDays!.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: TargetDayWidget(
                            id: target!.id!,
                            index: index,
                            targetDays: target!.targetDays!,
                            statusOfDay: passesDaysCount == index
                                ? StatusOfDay.active
                                : passesDaysCount > index
                                    ? StatusOfDay.hasPassed
                                    : passesDaysCount < index
                                        ? StatusOfDay.notArrived
                                        : StatusOfDay.active,
                          ),
                        );
                      },
                    ),
                  ),
                  if (target!.todos?.isNotEmpty ?? false) ...[
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                      'تسک هایی که باید در طول هدف انجام دهم 📄',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: height / 70,
                    ),
                    Column(
                      children: List.generate(
                        target!.todos?.length ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (target!.todos?[index].completed == 0) {
                                    if (_targetsProvider.status != AppState.loading) {
                                      setState(() {
                                        target!.todos?[index].completed = 1;
                                      });
                                      _targetsProvider.updateTargetTodos(
                                        context: context,
                                        id: target!.id!,
                                        todos: target!.todos!,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    ),
                                  ),
                                  child: target!.todos?[index].completed == 1
                                      ? Icon(
                                          Icons.check,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                target!.todos![index].title!,
                                style: target!.todos?[index].completed == 1
                                    ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Theme.of(context).primaryColor,
                                          decorationThickness: 3,
                                        )
                                    : Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
