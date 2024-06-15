class DietPlan {
  int? id;
  String? startDate;
  String? endDate;
  int? editable;
  List<DietPlanDay>? dietPlanDays;

  DietPlan({
    this.id,
    this.startDate,
    this.endDate,
    this.editable,
    this.dietPlanDays,
  });

  DietPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    editable = json['editable'];
    if (json['diet_plan_days'] != null) {
      dietPlanDays = <DietPlanDay>[];
      json['diet_plan_days'].forEach((v) {
        dietPlanDays!.add(DietPlanDay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['editable'] = editable;
    if (dietPlanDays != null) {
      data['diet_plan_days'] = dietPlanDays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DietPlanDay {
  String? title;
  List<Meal>? meals;

  DietPlanDay({this.title, this.meals});

  DietPlanDay.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['meals'] != null) {
      meals = <Meal>[];
      json['meals'].forEach((v) {
        meals!.add(Meal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meal {
  String? name;
  String? status;
  List<String>? edibles;

  Meal({this.name, this.edibles});

  Meal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    edibles = json['edibles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['edibles'] = edibles;
    return data;
  }
}
