import 'package:hamrah_salamat/Core/utils/enums.dart';

class Translation {
  static final Map<dynamic, dynamic> translator = {
    Gender.male: 'آقا',
    Gender.female: 'خانم',
    "شنبه": DateTime.saturday,
    "یکشنبه": DateTime.sunday,
    "دوشنبه": DateTime.monday,
    "سه شنبه": DateTime.tuesday,
    "چهارشنبه": DateTime.wednesday,
    "پنج شنبه": DateTime.thursday,
    "جمعه": DateTime.friday,
  };
}
