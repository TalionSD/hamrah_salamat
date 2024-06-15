import 'package:hamrah_salamat/Core/constants/data/days_of_week.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/diet_plan.dart';

class DietPlanController {
  bool checkEdibles({required List<DietPlanDay> dietPlanDays}) {
    bool foundEmptyEdibles = false;

    for (DietPlanDay dietPlanDay in dietPlanDays) {
      for (Meal meal in dietPlanDay.meals!) {
        if (meal.edibles?.isEmpty ?? true) {
          foundEmptyEdibles = true;
          break;
        }
      }
      if (foundEmptyEdibles) {
        break;
      }
    }

    return foundEmptyEdibles;
  }

  List<String> getNextDays(String startDay) {
    // Find the index of the starting day
    int startIndex = daysOfWeek.indexOf(startDay);

    if (startIndex == -1) {
      // If the day is not found in the list, return an empty list or handle the error as needed
      return [];
    }

    // Create a new list starting from the day after the start day
    List<String> result = [];
    for (int i = 1; i <= daysOfWeek.length; i++) {
      result.add(daysOfWeek[(startIndex + i) % daysOfWeek.length]);
    }

    return result;
  }
}
