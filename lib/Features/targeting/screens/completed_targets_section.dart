import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/empty_widget.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';
import 'package:hamrah_salamat/Features/targeting/screens/select_category_of_target_screen.dart';
import 'package:hamrah_salamat/Features/targeting/widgets/target_widget.dart';

class ColmpletedTargetsSection extends StatelessWidget {
  const ColmpletedTargetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<TargetsProvider>(
      builder: (context, targetsProvider, _) {
        List<Target>? targets = targetsProvider.completedTargets;

        if (targets?.isNotEmpty ?? false) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 30),
            child: AnimationList(
              duration: 1500,
              reBounceDepth: 30,
              cacheExtent: 50,
              children: List.generate(
                targets!.length,
                (index) {
                  Target target = targets[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height / 100),
                    child: TaregtWidget(
                      target: Target(
                        id: target.id!,
                        title: target.title!,
                        category: target.category!,
                        imageUrl: target.imageUrl!,
                        startDate: target.startDate!,
                        endDate: target.endDate!,
                        tags: target.tags!,
                        description: target.description!,
                        reminders: target.reminders,
                        todos: target.todos,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return EmptyWidget(
            content: Text(
              'هنوز هدف تکمیل شده ای ثبت نشده است!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            button: Button(
              onPressed: () {
                Navigator.pushNamed(context, SelectCategoryOfTargetScreen.routeName);
              },
              borderRadius: BorderRadius.circular(30),
              child: Wrap(
                children: [
                  const Icon(
                    Icons.add_box_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'ساخت هدف',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
