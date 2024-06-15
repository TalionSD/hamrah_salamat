import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/validator/field_validator.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/diet_plan.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/radio_button.dart';

class MealExpansionTile extends StatefulWidget {
  final TypeOfDietPlaning? dietPlanType;
  final Meal meal;
  final bool editable;
  final bool enable;
  final void Function(String)? onPressedSaveEdible;
  final void Function(String)? onPressedDeleteEdible;
  final void Function(String?)? onPressedChangeStatusOfMeal;

  const MealExpansionTile({
    Key? key,
    required this.dietPlanType,
    required this.meal,
    required this.editable,
    required this.enable,
    this.onPressedSaveEdible,
    this.onPressedChangeStatusOfMeal,
    this.onPressedDeleteEdible,
  }) : super(key: key);

  @override
  State<MealExpansionTile> createState() => _MealExpansionTileState();
}

class _MealExpansionTileState extends State<MealExpansionTile> {
  final GlobalKey<FormState> _addEdibleFormKey = GlobalKey<FormState>();
  final TextEditingController _addEdibleController = TextEditingController();

  List<TextEditingController> ediblesControllers = [];

  int? selectedIndex;

  final List<Map<String, dynamic>> statusOfMeal = <Map<String, dynamic>>[
    {
      'title': 'انجام دادم',
    },
    {
      'title': 'انجام ندادم',
    },
  ];

  @override
  void initState() {
    if (widget.meal.status != null) {
      for (int i = 0; i < statusOfMeal.length; i++) {
        if (statusOfMeal[i]['title'] == widget.meal.status) {
          selectedIndex = i;
        }
      }
    }
    super.initState();
  }

  IconData setLeading({required String name}) {
    IconData iconData = Icons.breakfast_dining;

    if (name == 'صبحانه') {
      iconData = Icons.breakfast_dining;
    } else if (name == 'ناهار') {
      iconData = Icons.lunch_dining;
    } else if (name == 'شام') {
      iconData = Icons.dinner_dining;
    } else if (name == 'میان وعده') {
      iconData = Icons.free_breakfast_rounded;
    }

    return iconData;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          leading: Icon(
            setLeading(name: widget.meal.name!),
          ),
          title: Text(
            widget.meal.name!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: widget.meal.edibles?.isEmpty ?? true
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.error,
                      ),
                      child: Text(
                        'خوراکی وارد نشده است!',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        runSpacing: 10,
                        children: List.generate(
                          widget.meal.edibles?.length ?? 0,
                          (index) => Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Text(
                                  widget.meal.edibles?[index] ?? '',
                                ),
                              ),
                              if (index != (widget.meal.edibles?.length ?? 0) - 1) const Icon(Icons.add),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 20, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: widget.meal.edibles?.isNotEmpty ?? false ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  if ((widget.meal.edibles?.isNotEmpty ?? false) && widget.enable)
                    Row(
                      children: statusOfMeal.map((item) {
                        int index = statusOfMeal.indexOf(item);
                        bool isSelected = selectedIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: RadioButton(
                            context: context,
                            title: item['title'],
                            isSelected: isSelected,
                            index: index,
                            onTap: (idx) {
                              setState(() {
                                if (selectedIndex == index) {
                                  selectedIndex = null;
                                } else {
                                  selectedIndex = index;
                                }
                              });

                              if (selectedIndex != null) {
                                widget.onPressedChangeStatusOfMeal!(
                                  statusOfMeal[selectedIndex!]['title'],
                                );
                              } else {
                                widget.onPressedChangeStatusOfMeal!(
                                  null,
                                );
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  if (widget.editable)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          ediblesControllers = List.generate(
                            widget.meal.edibles?.length ?? 0,
                            (index) => TextEditingController(
                              text: widget.meal.edibles?[index],
                            ),
                          );
                        });

                        showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, changeState) => AlertDialog(
                              content: Form(
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    children: [
                                      ...List.generate(
                                        ediblesControllers.length,
                                        (index) => Padding(
                                          padding: EdgeInsets.only(bottom: height / 50),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 10,
                                                fit: FlexFit.tight,
                                                child: TextFormField(
                                                  enabled: false,
                                                  controller: ediblesControllers[index],
                                                  decoration: const InputDecoration(
                                                    label: Text('نام خوراکی'),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 2,
                                                fit: FlexFit.tight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    changeState(() {
                                                      ediblesControllers.remove(ediblesControllers[index]);
                                                    });

                                                    widget.onPressedDeleteEdible!(widget.meal.edibles![index]);
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Theme.of(context).colorScheme.error,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: SizedBox(
                                              width: width,
                                              child: Form(
                                                key: _addEdibleFormKey,
                                                child: Wrap(
                                                  children: [
                                                    TextFormField(
                                                      controller: _addEdibleController,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(40),
                                                        CustomTextInputFormatter(),
                                                      ],
                                                      decoration: const InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        label: Text('نام خوراکی'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: height / 50),
                                                      child: Button(
                                                        width: width,
                                                        onPressed: () {
                                                          if (_addEdibleFormKey.currentState!.validate()) {
                                                            _addEdibleFormKey.currentState!.save();
                                                            widget.onPressedSaveEdible!(
                                                              _addEdibleController.text,
                                                            );

                                                            _addEdibleController.clear();
                                                            Navigator.pop(context);
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        child: Text(
                                                          'تایید',
                                                          style: Theme.of(context).textTheme.labelMedium,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: linearGradient(context: context),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Theme.of(context).colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Ink(
                        child: Wrap(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('ویرایش'),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
