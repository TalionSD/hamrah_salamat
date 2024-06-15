import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Features/profile/data/yoga_exercises.dart';
import 'package:hamrah_salamat/Features/home/widgets/training_introduction_widget.dart';
import 'package:hamrah_salamat/Features/profile/screens/sport_and_yoga_training_view_screen.dart';

class YogaExercisesScreen extends StatelessWidget {
  static const String routeName = '/yoga_exercises_screen';

  const YogaExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(title: 'تمرینات یوگا'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: AnimationList(
          duration: 1500,
          reBounceDepth: 30,
          cacheExtent: 50,
          children: List.generate(
            yogaExercises.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height / 100),
                child: TrainingIntroductionWidget(
                  lottieUrl: yogaExercises[index]['lottie_url'],
                  title: yogaExercises[index]['title'],
                  description: yogaExercises[index]['description'],
                  color: yogaExercises[index]['color'],
                  lottieScale: 1.2,
                  onTap: () => Navigator.pushNamed(
                    context,
                    SportAndYogaTrainingViewScreen.routeName,
                    arguments: {
                      "title": yogaExercises[index]['title'],
                      "lottie_url": yogaExercises[index]['lottie_url'],
                      "description": yogaExercises[index]['description'],
                      "perform_movements": yogaExercises[index]['perform_movements'],
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
