import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:lottie/lottie.dart';

class SportAndYogaTrainingViewScreen extends StatelessWidget {
  static const String routeName = '/sport_and_yoga_training_view_screen';

  const SportAndYogaTrainingViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    Map<String, dynamic>? practice;
    practice = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    List performMovements = practice!['perform_movements'];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      bottomSheet: Container(
        height: height / 2 + 50,
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
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              spreadRadius: 1.5,
              blurRadius: 4,
              offset: const Offset(4, 0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
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
              SelectableText(
                practice['title'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: height / 50,
              ),
              SelectableText(
                practice['description'],
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: height / 50,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'مراحل انجام حرکت: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: height / 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  performMovements.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            gradient: linearGradient(context: context),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width - 80,
                          child: SelectableText(
                            performMovements[index],
                            textAlign: TextAlign.justify,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 30,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Lottie.asset(
            height: height / 3 + 50,
            practice['lottie_url'],
          ),
        ),
      ),
    );
  }
}
