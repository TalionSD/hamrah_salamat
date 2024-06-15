import 'package:flutter/material.dart';

class CustomTimeLine extends StatelessWidget {
  final int stepIndex;
  final void Function()? onTap;
  const CustomTimeLine({
    super.key,
    required this.stepIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> steps = <String>[
      'ارزیابی شاخص توده بدنی',
      'بررسی وضعیت شاخص توده بدنی',
      'مشاهده نیازهای بدن',
      'انتخاب شیوه  برنامه غذایی',
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              steps[stepIndex - 1],
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
            ),
            if (stepIndex != 4)
              GestureDetector(
                onTap: onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'مرحله بعد',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                    ),
                  ],
                ),
              )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            step(context: context, index: 1, enable: stepIndex == 1),
            line(context: context),
            step(context: context, index: 2, enable: stepIndex == 2),
            line(context: context),
            step(context: context, index: 3, enable: stepIndex == 3),
            line(context: context),
            step(context: context, index: 4, enable: stepIndex == 4),
          ],
        ),
      ],
    );
  }

  Widget line({required BuildContext context}) {
    return Expanded(
      child: Divider(
        color: Theme.of(context).colorScheme.tertiary,
        thickness: 2,
      ),
    );
  }

  Widget step({
    required BuildContext context,
    required int index,
    required bool enable,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: enable ? Theme.of(context).primaryColor : null,
        border: Border.all(color: Theme.of(context).colorScheme.tertiary, width: 2),
      ),
      child: Text(
        index.toString(),
        style: TextStyle(
          color: enable ? Theme.of(context).colorScheme.tertiary : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
