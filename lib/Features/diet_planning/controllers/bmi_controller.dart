import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/bmi_status.dart';
import 'package:hamrah_salamat/Features/diet_planning/data/bmi_status_formatter.dart';

class BMIController {
  BmiStatus getBMIStatus({
    required double bmi,
    required int age,
    required Gender gender,
  }) {
    String status = "";
    String description = "";
    String imageUrl = "";
    double? excessWeight;
    double? weightLoss;

    String category = "";

    // To determine the user's age and gender status
    switch (gender) {
      case Gender.male:
        category = age <= 18 ? "maleUnder18" : "maleAbove18";
        break;
      case Gender.female:
        category = age <= 18 ? "femaleUnder18" : "femaleAbove18";
        break;
      default:
        category = "Invalid";
    }

    // To determine the status of body mass index
    switch (category) {
      case "maleUnder18":
        switch (bmi >= 18.5 && bmi < 24.9) {
          case true:
            {
              status = BMIStatusFormatter.normalWeightStatus;
              description = BMIStatusFormatter.normalWeightDescription;
              imageUrl = "assets/images/diet_planning/normal.png";
            }
            break;
          default:
            {
              status = bmi < 18.5 ? BMIStatusFormatter.underWeightStatus : BMIStatusFormatter.overWeightStatus;
              description = bmi < 18.5 ? BMIStatusFormatter.underWeightStatusDescription : BMIStatusFormatter.overWeightStatusDescription;
              imageUrl = bmi < 18.5 ? "assets/images/diet_planning/thin.png" : "assets/images/diet_planning/fat.png";
            }
            if (status == BMIStatusFormatter.overWeightStatus) {
              excessWeight = bmi - 24.9;
            } else {
              weightLoss = 18.5 - bmi;
            }
        }
        break;
      case "maleAbove18":
        switch (bmi >= 20.7 && bmi < 26.4) {
          case true:
            {
              status = BMIStatusFormatter.normalWeightStatus;
              description = BMIStatusFormatter.normalWeightDescription;
              imageUrl = "assets/images/diet_planning/normal.png";
            }
            break;
          default:
            {
              status = bmi < 20.7 ? BMIStatusFormatter.underWeightStatus : BMIStatusFormatter.overWeightStatus;
              description = bmi < 20.7 ? BMIStatusFormatter.underWeightStatusDescription : BMIStatusFormatter.overWeightStatusDescription;
              imageUrl = bmi < 20.7 ? "assets/images/diet_planning/thin.png" : "assets/images/diet_planning/fat.png";
            }
            if (status == BMIStatusFormatter.overWeightStatus) {
              excessWeight = bmi - 26.4;
            } else {
              weightLoss = 20.7 - bmi;
            }
        }
        break;
      case "femaleUnder18":
        switch (bmi >= 18.5 && bmi < 24.9) {
          case true:
            {
              status = BMIStatusFormatter.normalWeightStatus;
              description = BMIStatusFormatter.normalWeightDescription;
              imageUrl = "assets/images/diet_planning/normal.png";
            }
            break;
          default:
            {
              status = bmi < 18.5 ? BMIStatusFormatter.underWeightStatus : BMIStatusFormatter.overWeightStatus;
              description = bmi < 18.5 ? BMIStatusFormatter.underWeightStatusDescription : BMIStatusFormatter.overWeightStatusDescription;
              imageUrl = bmi < 18.5 ? "assets/images/diet_planning/thin.png" : "assets/images/diet_planning/fat.png";
            }
            if (status == BMIStatusFormatter.overWeightStatus) {
              excessWeight = bmi - 24.9;
            } else {
              weightLoss = 18.5 - bmi;
            }
        }
        break;
      case "femaleAbove18":
        switch (bmi >= 19.1 && bmi < 25.8) {
          case true:
            {
              status = BMIStatusFormatter.normalWeightStatus;
              description = BMIStatusFormatter.normalWeightDescription;
              imageUrl = "assets/images/diet_planning/normal.png";
            }
            break;
          default:
            {
              status = bmi < 19.1 ? BMIStatusFormatter.underWeightStatus : BMIStatusFormatter.overWeightStatus;
              description = bmi < 19.1 ? BMIStatusFormatter.underWeightStatusDescription : BMIStatusFormatter.overWeightStatusDescription;
              imageUrl = bmi < 19.1 ? "assets/images/diet_planning/thin.png" : "assets/images/diet_planning/fat.png";
            }
            if (status == BMIStatusFormatter.overWeightStatus) {
              excessWeight = bmi - 25.8;
            } else {
              weightLoss = 19.1 - bmi;
            }
        }
        break;
      default:
        {
          status = "اطلاعات نامعتبر است!";
          description = "توضیحاتی یافت نشد!";
        }
    }

    return BmiStatus(
      status: status,
      imageUrl: imageUrl,
      description: description,
      excessWeight: excessWeight?.toStringAsFixed(1),
      weightLoss: weightLoss?.toStringAsFixed(1),
    );
  }

  double calculateBMI({
    required double height,
    required double weight,
  }) {
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);
    return double.parse(bmi.toStringAsFixed(2));
  }
}
