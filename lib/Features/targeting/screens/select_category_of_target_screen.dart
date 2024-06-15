import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/create_target_controller.dart';
import 'package:hamrah_salamat/Features/targeting/data/categories_of_targets.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';
import 'package:hamrah_salamat/Features/targeting/screens/select_tags_of_target_screen.dart';

class SelectCategoryOfTargetScreen extends StatefulWidget {
  static const String routeName = '/select_category_of_target_screen';

  const SelectCategoryOfTargetScreen({super.key});

  @override
  State<SelectCategoryOfTargetScreen> createState() => _SelectCategoryOfTargetScreenState();
}

class _SelectCategoryOfTargetScreenState extends State<SelectCategoryOfTargetScreen> {
  late TargetingController _targetingController;

  late List<String> _categoriesTitle;
  late List<String> _categoriesImage;
  int? _selectedIndex;

  @override
  void initState() {
    _targetingController = TargetingController();
    _categoriesTitle = _targetingController.extractDataFromJson(
      data: categoriesOfTargets,
      desiredItem: 'title',
    );
    _categoriesImage = _targetingController.extractDataFromJson(
      data: categoriesOfTargets,
      desiredItem: 'image_url',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: 'انتخاب دسته بندی'),
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
                      'دسته بندی هدف خود را انتخاب کنید',
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
                    'مرحله 1 از 3',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: _categoriesTitle.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        if (_selectedIndex == index) {
                          _selectedIndex = null;
                        } else {
                          _selectedIndex = index;
                        }
                      }),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height / 100),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: linearGradient(context: context),
                              ),
                              child: Image(
                                image: AssetImage(_categoriesImage[index]),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              _categoriesTitle[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Consumer<TargetsProvider>(
              builder: (context, targetsProvider, _) => Button(
                width: width,
                onPressed: () {
                  if (_selectedIndex != null) {
                    targetsProvider.setValueForTarget(
                      target: Target(
                        category: _categoriesTitle[_selectedIndex!],
                        imageUrl: _categoriesImage[_selectedIndex!],
                      ),
                    );

                    Navigator.pushNamed(
                      context,
                      SelectTagsOfTargetScreen.routeName,
                    );
                  } else {
                    showSnackBar(
                      context,
                      message: 'لطفا ابتدا یک دسته بندی انتخاب کنید',
                      snackbarType: SnackBarType.error,
                    );
                  }
                },
                child: Text(
                  'تایید',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
