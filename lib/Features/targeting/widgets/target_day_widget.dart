import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/validator/field_validator.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/create_target_controller.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';

class TargetDayWidget extends StatefulWidget {
  final int id;
  final int index;
  final StatusOfDay statusOfDay;
  final void Function()? onPressedSetLog;
  final List<TargetDay> targetDays;

  const TargetDayWidget({
    Key? key,
    required this.index,
    required this.statusOfDay,
    this.onPressedSetLog,
    required this.targetDays,
    required this.id,
  }) : super(key: key);

  @override
  State<TargetDayWidget> createState() => _TargetDayWidgetState();
}

class _TargetDayWidgetState extends State<TargetDayWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  late TargetsProvider _targetsProvider;
  late TargetingController _targetingController;

  String? _reactionImage;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _reactions = <Map<String, dynamic>>[
    {
      "title": "عالی بود، بهتر از این نمیشد",
      "image_url": "assets/images/reactions/excellent.png",
    },
    {
      "title": "خیلی خوب انجامش دادم",
      "image_url": "assets/images/reactions/very_good.png",
    },
    {
      "title": "با موفقیت انجامش دادم",
      "image_url": "assets/images/reactions/good.png",
    },
    {
      "title": "زیاد خوب انجامش ندادم",
      "image_url": "assets/images/reactions/bad.png",
    },
    {
      "title": "باید تلاشمو بیشتر کنم",
      "image_url": "assets/images/reactions/very_bad.png",
    },
  ];

  @override
  void initState() {
    _targetsProvider = Provider.of(context, listen: false);
    _targetingController = TargetingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (widget.targetDays[widget.index].reaction != null) {
          setState(() {
            _reactionImage = _targetingController.findImageUrlByTitle(
              widget.targetDays[widget.index].reaction!,
              _reactions,
            );
          });
        }
        widget.statusOfDay == StatusOfDay.active && widget.targetDays[widget.index].description == null
            ? showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, changeState) => AlertDialog(
                    content: SizedBox(
                      width: width,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'این فیلد نمیتواند خالی باشد';
                                } else if (value!.length < 5) {
                                  return 'کمتر از 5 حرف مجاز نمیباشد';
                                }
                                return null;
                              },
                              controller: _descriptionController,
                              maxLines: 5,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(160),
                                CustomTextInputFormatter(),
                              ],
                              decoration: const InputDecoration(
                                floatingLabelAlignment: FloatingLabelAlignment.center,
                                label: Text('توضیحات'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 50),
                            child: SizedBox(
                              height: height / 7 + 20,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _reactions.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        changeState(() {
                                          _selectedIndex = index;
                                        });
                                      }),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _selectedIndex == index ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).colorScheme.tertiary,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: _selectedIndex == index ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.tertiary,
                                            width: 2,
                                          ),
                                          boxShadow: _selectedIndex == index
                                              ? [
                                                  BoxShadow(
                                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                width: 60,
                                                image: AssetImage(
                                                  _reactions[index]['image_url'],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 80,
                                                child: Text(
                                                  _reactions[index]['title'],
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 50),
                            child: Button(
                              width: width,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  setState(() {
                                    widget.targetDays[widget.index] = TargetDay(
                                      description: _descriptionController.text,
                                      reaction: _reactions[_selectedIndex]['title'],
                                    );
                                  });

                                  if (_targetsProvider.status != AppState.loading) {
                                    _targetsProvider.updateTargetDays(
                                      context: context,
                                      id: widget.id,
                                      targetDays: widget.targetDays,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'ثبت کارکرد امروز',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : widget.statusOfDay != StatusOfDay.notArrived
                ? showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, changeState) => Container(
                          padding: EdgeInsets.only(
                            right: width / 30,
                            left: width / 30,
                            top: height / 100,
                            bottom: height / 40,
                          ),
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
                                  height: height / 30,
                                ),
                                widget.targetDays[widget.index].description != null
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              text: 'توضیحات : ',
                                              children: [
                                                TextSpan(
                                                  text: widget.targetDays[widget.index].description,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'واکنش : ',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                              Image(
                                                width: 60,
                                                image: AssetImage(_reactionImage!),
                                              ),
                                              Text(
                                                widget.targetDays[widget.index].reaction!,
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).colorScheme.error,
                                        ),
                                        child: Text(
                                          'یادداشتی برای این روز ثبت نشده است',
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : null;
      },
      child: Container(
        padding: widget.statusOfDay == StatusOfDay.active ? const EdgeInsets.all(2) : null,
        decoration: widget.statusOfDay == StatusOfDay.active
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              )
            : null,
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.statusOfDay == StatusOfDay.active
                ? Theme.of(context).primaryColor
                : widget.statusOfDay == StatusOfDay.hasPassed
                    ? Theme.of(context).colorScheme.onSurface
                    : widget.statusOfDay == StatusOfDay.notArrived
                        ? Theme.of(context).colorScheme.tertiary
                        : Colors.transparent,
          ),
          child: Text(
            (widget.index + 1).toString(),
          ),
        ),
      ),
    );
  }
}
