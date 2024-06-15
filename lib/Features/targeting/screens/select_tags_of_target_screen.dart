import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/create_target_controller.dart';
import 'package:hamrah_salamat/Features/targeting/data/categories_of_targets.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';
import 'package:hamrah_salamat/Features/targeting/screens/completing_target_build_information_screen.dart';

class SelectTagsOfTargetScreen extends StatefulWidget {
  static const String routeName = '/select_tags_of_target_screen';

  const SelectTagsOfTargetScreen({super.key});

  @override
  State<SelectTagsOfTargetScreen> createState() => _SelectTagsOfTargetScreenState();
}

class _SelectTagsOfTargetScreenState extends State<SelectTagsOfTargetScreen> {
  late TargetingController _targetingColtroller;
  late TargetsProvider _targetsProvider;

  List<String> _categoryTags = [];
  final List<String> _selectedTags = [];

  @override
  void initState() {
    _targetingColtroller = TargetingController();
    _targetsProvider = Provider.of<TargetsProvider>(context, listen: false);

    _categoryTags = _targetingColtroller.extractDataFromJson(
      data: categoriesOfTargets,
      desiredItem: 'tags',
      categoryTitle: _targetsProvider.target?.category,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: 'انتخاب تگ ها'),
      body: Padding(
        padding: edgeInsetsGeometryOfScreens(context: context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ساخت هدف جدید 🎯',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: height / 150,
                    ),
                    Text(
                      'تگ های مورد نظر هدف خود را انتخاب کنید',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'مرحله 2 از 3',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Wrap(
              runSpacing: 10,
              children: List.generate(_categoryTags.length, (index) {
                bool isSelected = _selectedTags.contains(_categoryTags[index]);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTags.remove(_categoryTags[index]);
                        } else {
                          _selectedTags.add(_categoryTags[index]);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.tertiary,
                          width: 2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        _categoryTags[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            Button(
              width: width,
              onPressed: () {
                if (_selectedTags.isNotEmpty) {
                  _targetsProvider.setValueForTarget(
                    target: Target(
                      category: _targetsProvider.target?.category,
                      imageUrl: _targetsProvider.target?.imageUrl,
                      tags: _selectedTags,
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    CompletingTargetBuildInformationScreen.routeName,
                  );
                } else {
                  showSnackBar(
                    context,
                    message: 'لطفا حداقل یک تگ انتخاب نمایید',
                    snackbarType: SnackBarType.error,
                  );
                }
              },
              child: Text(
                'تایید',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
