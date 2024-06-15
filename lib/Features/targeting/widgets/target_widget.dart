import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:hamrah_salamat/Features/targeting/controllers/create_target_controller.dart';
import 'package:hamrah_salamat/Features/targeting/screens/target_details_screen.dart';

class TaregtWidget extends StatelessWidget {
  final Target target;

  const TaregtWidget({
    super.key,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    TargetingController targetingController = TargetingController();
    final height = MediaQuery.of(context).size.height;
    Jalali todayDate = Jalali.now();
    String formattedDate = '${todayDate.year}/${todayDate.month}/${todayDate.day}';
    bool active = targetingController.isSecondDateNotGreaterThanFirst(target.endDate!, formattedDate);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, TargetDetailsScreen.routeName, arguments: target),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      height: height / 10,
                      image: AssetImage(target.imageUrl!),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!active)
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 70),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 216, 239, 217)),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                ],
              ),
            ),
            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Container(
                decoration: const BoxDecoration(),
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
                              target.title!,
                              style: Theme.of(context).textTheme.titleSmall,
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
                                    target.startDate!,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surface),
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
                                    target.endDate!,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surface),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          text: 'دسته بندی : ',
                          children: [
                            TextSpan(
                              text: target.category!,
                              style: Theme.of(context).textTheme.bodySmall,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          ...List.generate(
                            target.tags!.length,
                            (index) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                              margin: const EdgeInsets.only(left: 5, bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                target.tags![index],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                              ),
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'توضیحات : ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: target.description!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
