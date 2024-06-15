import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';
import 'package:hamrah_salamat/Core/constants/data/days_of_week.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/utils/helper.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';

class ReminderManagerWidget extends StatelessWidget {
  final BuildContext context;
  final List<Reminder> reminderItems;
  final List<String>? daysWithoutAlarm;
  final void Function(String, int, TimeOfDay)? onChangeTime;
  final void Function(Reminder)? onTapDeleteDay;
  final void Function(Reminder)? createReminder;
  final void Function(String)? addDayToListdaysWithoutAlarm;
  final void Function()? clearDaysWithoutAlarm;
  final void Function(String, TimeOfDay)? addAlarmForDay;

  const ReminderManagerWidget({
    super.key,
    required this.context,
    required this.reminderItems,
    this.daysWithoutAlarm,
    this.onChangeTime,
    this.onTapDeleteDay,
    this.createReminder,
    this.addDayToListdaysWithoutAlarm,
    this.addAlarmForDay,
    this.clearDaysWithoutAlarm,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(right: width / 30, left: width / 30, top: height / 100, bottom: height / 40),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 8,
              width: width / 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Text(
              'یادآوری در روزهای دلخواه',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: height / 100,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                ...List.generate(
                  reminderItems.length,
                  (index) {
                    return Container(
                      width: width / 3,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(20),
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
                              reminderItems[index].day!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                          Column(
                            children: List.generate(
                              reminderItems[index].times?.length ?? 0,
                              (timeIndex) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    showPersianTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(hour: reminderItems[index].times![timeIndex].hour!, minute: reminderItems[index].times![timeIndex].minute!),
                                      initialEntryMode: PTimePickerEntryMode.dialOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                              colorScheme: ColorScheme(
                                            primary: hexToColor("#3b82f6"),
                                            secondary: hexToColor("#8b5cf6"),
                                            tertiary: hexToColor("#ffffff"),
                                            surface: hexToColor("#f2f7f2"),
                                            onSurface: hexToColor("#647067"),
                                            error: hexToColor("#f43f5e"),
                                            onError: hexToColor('#ffe4e7'),
                                            onPrimary: hexToColor("#ffe4e7"),
                                            onSecondary: hexToColor("#ffe4e7"),
                                            brightness: Brightness.light,
                                          )),
                                          child: child!,
                                        );
                                      },
                                    ).then((timeOfDay) {
                                      if (timeOfDay != null) {
                                        onChangeTime!(
                                          reminderItems[index].day!,
                                          timeIndex,
                                          timeOfDay,
                                        );
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${reminderItems[index].times?[timeIndex].hour}:${reminderItems[index].times?[timeIndex].minute}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: linearGradient(context: context),
                                        ),
                                        child: Icon(
                                          Icons.edit_notifications_outlined,
                                          size: 17,
                                          color: Theme.of(context).colorScheme.tertiary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (reminderItems[index].times!.length >= 3) {
                                    showSnackBar(context, message: 'امکان اضافه کردن آلارم بیشتری برای این روز وجود ندارد!', snackbarType: SnackBarType.error);
                                  } else {
                                    showPersianTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      initialEntryMode: PTimePickerEntryMode.dialOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                              colorScheme: ColorScheme(
                                            primary: hexToColor("#3b82f6"),
                                            secondary: hexToColor("#8b5cf6"),
                                            tertiary: hexToColor("#ffffff"),
                                            surface: hexToColor("#f2f7f2"),
                                            onSurface: hexToColor("#647067"),
                                            error: hexToColor("#f43f5e"),
                                            onError: hexToColor('#ffe4e7'),
                                            onPrimary: hexToColor("#ffe4e7"),
                                            onSecondary: hexToColor("#ffe4e7"),
                                            brightness: Brightness.light,
                                          )),
                                          child: child!,
                                        );
                                      },
                                    ).then((timeOfDay) {
                                      if (timeOfDay != null) {
                                        addAlarmForDay!(
                                          reminderItems[index].day!,
                                          timeOfDay,
                                        );
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: linearGradient(context: context),
                                  ),
                                  child: Icon(
                                    Icons.add_alarm,
                                    size: 17,
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  onTapDeleteDay!(reminderItems[index]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).colorScheme.error,
                                        Theme.of(context).colorScheme.onError,
                                      ],
                                      begin: Alignment.center,
                                      end: Alignment.topLeft,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 17,
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                if (reminderItems.length < 7 || reminderItems.isEmpty)
                  GestureDetector(
                    onTap: () {
                      clearDaysWithoutAlarm!();
                      List<String?> daysWithReminder = [];
                      for (Reminder reminderItem in reminderItems) {
                        daysWithReminder.add(reminderItem.day);
                      }
                      for (String day in daysOfWeek) {
                        if (!daysWithReminder.contains(day)) {
                          addDayToListdaysWithoutAlarm!(day);
                        }
                      }
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Wrap(
                            runSpacing: 10,
                            children: List.generate(
                              daysWithoutAlarm!.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () {
                                    showPersianTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      initialEntryMode: PTimePickerEntryMode.dialOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                              colorScheme: ColorScheme(
                                            primary: hexToColor("#3b82f6"),
                                            secondary: hexToColor("#8b5cf6"),
                                            tertiary: hexToColor("#ffffff"),
                                            surface: hexToColor("#f2f7f2"),
                                            onSurface: hexToColor("#647067"),
                                            error: hexToColor("#f43f5e"),
                                            onError: hexToColor('#ffe4e7'),
                                            onPrimary: hexToColor("#ffe4e7"),
                                            onSecondary: hexToColor("#ffe4e7"),
                                            brightness: Brightness.light,
                                          )),
                                          child: child!,
                                        );
                                      },
                                    ).then((timeOfDay) {
                                      if (timeOfDay != null) {
                                        createReminder!(
                                          Reminder(
                                            day: daysWithoutAlarm![index],
                                            times: [Time(hour: timeOfDay.hour, minute: timeOfDay.minute)],
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context).colorScheme.tertiary,
                                      border: Border.all(color: Theme.of(context).primaryColor),
                                    ),
                                    child: Text(
                                      daysWithoutAlarm![index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(15),
                        width: width / 4,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          gradient: linearGradient(context: context),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
