import 'package:hamrah_salamat/Core/utils/enums.dart';

class User {
  String? fullname;
  String? imageUrl;
  int? age;
  String? gender;
  double? weight;
  double? height;
  String? bmiStatus;
  ActivityLevel? activityLevel;

  User({
    this.fullname,
    this.imageUrl,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.bmiStatus,
    this.activityLevel,
  });

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    imageUrl = json['image_url'];
    age = json['age'];
    gender = json['gender'];
    weight = json['weight'];
    height = json['height'];
    bmiStatus = json['bmi_status'];
    activityLevel = json['activity_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['image_url'] = imageUrl;
    data['age'] = age;
    data['gender'] = gender;
    data['weight'] = weight;
    data['height'] = height;
    data['bmi_status'] = bmiStatus;
    data['activity_level'] = activityLevel;
    return data;
  }
}
