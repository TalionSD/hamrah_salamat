import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/nutrition_need.dart';
import 'package:hamrah_salamat/Features/diet_planning/data/bmi_status_formatter.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';

class BMRController {
  NutritionNeeds calculateNutritionNeeds({
    required User user,
  }) {
    double bmr = _calculateBMR(
      user: User(
        height: user.height,
        weight: user.weight,
        age: user.age,
        gender: user.gender,
      ),
    );
    double calories;
    double calorieReductionPercentage;
    double calorieAdjustmentPercentage;

    // Determine calorie adjustment percentage based on activity level
    switch (user.activityLevel) {
      case ActivityLevel.noActivity:
        calorieAdjustmentPercentage = 0.0; // 0% adjustment for no activity
        break;
      case ActivityLevel.lowActivity:
        calorieAdjustmentPercentage = 0.05; // 5% adjustment for low activity
        break;
      case ActivityLevel.moderateActivity:
        calorieAdjustmentPercentage = 0.15; // 10% adjustment for moderate activity
        break;
      case ActivityLevel.highActivity:
        calorieAdjustmentPercentage = 0.30; // 20% adjustment for high activity
        break;
      default:
        calorieAdjustmentPercentage = 0.0; // Default to no adjustment
    }

    if (user.bmiStatus == BMIStatusFormatter.normalWeightStatus) {
      // Calculate maintenance calories needed to stay at the same weight
      calories = bmr * (1.2 + calorieAdjustmentPercentage); // Adjusted for activity level
    } else if (user.bmiStatus == BMIStatusFormatter.underWeightStatus) {
      // Calculate calories needed to gain weight by 10%
      calorieReductionPercentage = 0.10;
      calories = bmr * (1.2 + calorieReductionPercentage + calorieAdjustmentPercentage); // Adjusted for activity level
    } else if (user.bmiStatus == BMIStatusFormatter.overWeightStatus) {
      // Reduce daily calorie intake by 10%
      calorieReductionPercentage = -0.10; // Negative value for decrease
      calories = bmr * (1.2 + calorieReductionPercentage + calorieAdjustmentPercentage); // Adjusted for activity level
    } else {
      throw ArgumentError("Invalid BMI status");
    }

    // Calculate daily protein needs (15% of total calories)
    double protein = (calories * 0.15) / 4; // 1 gram of protein = 4 calories

    // Calculate daily carbohydrate needs (55% of total calories)
    double carbohydrates = (calories * 0.55) / 4; // 1 gram of carbohydrate = 4 calories

    // Calculate daily fat needs (30% of total calories)
    double lipid = (calories * 0.30) / 9; // 1 gram of fat = 9 calories

    return NutritionNeeds(
      calories: calories.toStringAsFixed(0),
      carbohydrates: carbohydrates.toStringAsFixed(0),
      protein: protein.toStringAsFixed(0),
      lipid: lipid.toStringAsFixed(0),
    );
  }

  double _calculateBMR({
    required User user,
  }) {
    double bmr;

    if (user.gender == "آقا") {
      bmr = 66.5 + (13.75 * user.weight!) + (5.003 * user.height!) - (6.755 * user.age!);
    } else if (user.gender == "خانم") {
      bmr = 655.1 + (9.563 * user.weight!) + (1.850 * user.height!) - (4.676 * user.age!);
    } else {
      throw ArgumentError("Invalid gender");
    }

    return bmr;
  }
}
