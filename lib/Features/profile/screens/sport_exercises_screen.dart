import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Features/profile/data/sport_exercises.dart';
import 'package:hamrah_salamat/Features/home/widgets/training_introduction_widget.dart';
import 'package:hamrah_salamat/Features/profile/screens/sport_and_yoga_training_view_screen.dart';

class SportExercisesScreen extends StatelessWidget {
  static const String routeName = '/sport_exercises_screen';

  const SportExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(title: 'تمرینات ورزشی'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: AnimationList(
          duration: 1500,
          reBounceDepth: 30,
          cacheExtent: 50,
          children: List.generate(
            sportExercises.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height / 100),
                child: TrainingIntroductionWidget(
                  lottieUrl: sportExercises[index]['lottie_url'],
                  title: sportExercises[index]['title'],
                  description: sportExercises[index]['description'],
                  color: sportExercises[index]['color'],
                  lottieScale: 1.2,
                  onTap: () => Navigator.pushNamed(
                    context,
                    SportAndYogaTrainingViewScreen.routeName,
                    arguments: {
                      "title": sportExercises[index]['title'],
                      "lottie_url": sportExercises[index]['lottie_url'],
                      "description": sportExercises[index]['description'],
                      "perform_movements": sportExercises[index]['perform_movements'],
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
