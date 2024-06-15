import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class TargetingController {
  List<String> extractDataFromJson({
    required Map<String, dynamic> data,
    required String desiredItem,
    String? categoryTitle,
  }) {
    List<String> elements = [];
    List<dynamic> categories = data['categories'];

    if (desiredItem == "title") {
      for (dynamic category in categories) {
        elements.add(category[desiredItem]);
      }
    } else if (desiredItem == "image_url") {
      for (dynamic category in categories) {
        elements.add(category[desiredItem]);
      }
    } else if (desiredItem == "tags") {
      for (dynamic category in categories) {
        if (category['title'] == categoryTitle) {
          for (var a in category['tags']) {
            elements.add(a);
          }
        }
      }
    }

    return elements;
  }

  int calculateDifferenceDate(String fromDate, String toDate) {
    List<int> fromJalali = fromDate.split('/').map(int.parse).toList();
    List<int> toJalali = toDate.split('/').map(int.parse).toList();

    // Constants for number of days in each month
    List<int> jalaliMonthDays = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

    // Calculate days passed from Jalali year 1 to given Jalali year
    int daysFromJalaliYear1(int year) {
      return (year - 1) * 365 + ((year - 1) / 4).floor();
    }

    // Calculate days passed from Jalali year 1 to the given Jalali date
    int daysFromJalaliDate1(int year, int month, int day) {
      int totalDays = daysFromJalaliYear1(year);
      for (int i = 0; i < month - 1; i++) {
        totalDays += jalaliMonthDays[i];
      }
      return totalDays + day - 1;
    }

    int daysFromToJalaliDate1 = daysFromJalaliDate1(toJalali[0], toJalali[1], toJalali[2]);
    int daysFromFromJalaliDate1 = daysFromJalaliDate1(fromJalali[0], fromJalali[1], fromJalali[2]);

    return daysFromToJalaliDate1 - daysFromFromJalaliDate1;
  }

  bool isSecondDateNotGreaterThanFirst(String firstDateString, String secondDateString) {
    List<String> firstDateComponents = firstDateString.split('/');
    List<String> secondDateComponents = secondDateString.split('/');

    int firstYear = int.parse(firstDateComponents[0]);
    int firstMonth = int.parse(firstDateComponents[1]);
    int firstDay = int.parse(firstDateComponents[2]);

    int secondYear = int.parse(secondDateComponents[0]);
    int secondMonth = int.parse(secondDateComponents[1]);
    int secondDay = int.parse(secondDateComponents[2]);

    Jalali firstDate = Jalali(firstYear, firstMonth, firstDay);
    Jalali secondDate = Jalali(secondYear, secondMonth, secondDay);

    // Compare years
    if (secondDate.year > firstDate.year) {
      return false;
    } else if (secondDate.year < firstDate.year) {
      return true;
    }

    // If years are equal, compare months
    if (secondDate.month > firstDate.month) {
      return false;
    } else if (secondDate.month < firstDate.month) {
      return true;
    }

    // If years and months are equal, compare days
    if (secondDate.day > firstDate.day) {
      return false;
    }

    // If years, months, and days are equal or secondDate is before firstDate
    return true;
  }

  String? findImageUrlByTitle(String title, List<Map<String, dynamic>> reactions) {
    for (var reaction in reactions) {
      if (reaction["title"] == title) {
        return reaction["image_url"];
      }
    }
    return null;
  }
}
