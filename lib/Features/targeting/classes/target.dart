class Target {
  int? id;
  String? title;
  String? category;
  String? imageUrl;
  List<String>? tags;
  List<Reminder>? reminders;
  List<TargetDay>? targetDays;
  String? startDate;
  String? endDate;
  String? description;
  List<Todo>? todos;

  Target({
    this.id,
    this.title,
    this.category,
    this.imageUrl,
    this.tags,
    this.reminders,
    this.targetDays,
    this.startDate,
    this.endDate,
    this.description,
    this.todos,
  });

  Target.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    imageUrl = json['image_url'];
    tags = json['tags'].cast<String>();
    if (json['reminders'] != null) {
      reminders = <Reminder>[];
      json['reminders'].forEach((v) {
        reminders!.add(Reminder.fromJson(v));
      });
    }
    if (json['target_days'] != null) {
      targetDays = <TargetDay>[];
      json['target_days'].forEach((v) {
        targetDays!.add(TargetDay.fromJson(v));
      });
    }
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    if (json['todos'] != null) {
      todos = <Todo>[];
      json['todos'].forEach((v) {
        todos!.add(Todo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['image_url'] = imageUrl;
    data['tags'] = tags;
    if (reminders != null) {
      data['reminders'] = reminders!.map((v) => v.toJson()).toList();
    }
    if (targetDays != null) {
      data['target_days'] = targetDays!.map((v) => v.toJson()).toList();
    }
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['description'] = description;
    if (todos != null) {
      data['todos'] = todos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Todo {
  String? title;
  int? completed;

  Todo({
    this.title,
    this.completed,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['completed'] = completed;

    return data;
  }
}

class Reminder {
  String? day;
  List<Time>? times;

  Reminder({this.day, this.times});

  Reminder.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['times'] != null) {
      times = <Time>[];
      json['times'].forEach((v) {
        times!.add(Time.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    if (times != null) {
      data['times'] = times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TargetDay {
  String? description;
  String? reaction;

  TargetDay({
    this.description,
    this.reaction,
  });

  TargetDay.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    reaction = json['reaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['reaction'] = reaction;
    return data;
  }
}

class Time {
  int? hour;
  int? minute;

  Time({this.hour, this.minute});

  Time.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hour'] = hour;
    data['minute'] = minute;
    return data;
  }
}
