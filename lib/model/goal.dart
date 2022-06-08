import 'package:goal_setting_app/utils.dart';

class GoalField {
  static const createdTime = 'createdTime';
}

class Goal {
  DateTime createdTime;
  String title;
  String id;
  String task_desc;
  String uidHolder;
  String description;
  bool isDone;

  Goal({
    required this.createdTime,
    required this.title,
    required this.task_desc,
    required this.uidHolder,
    this.description = '',
    required this.id,
    this.isDone = false,
  });

  static Goal fromJson(Map<String, dynamic> json) => Goal(
    createdTime: Utils.toDateTime(json['createdTime']),
    title: json['title'],
    task_desc: json['task description'],
    uidHolder: json['uid'],
    description: json['description'],
    id: json['id'],
    isDone: json['isDone'],
  );

  Map<String, dynamic> toJson() => {
    'createdTime': Utils.fromDateTimeToJson(createdTime),
    'title': title,
    'task description': task_desc,
    'uid' : uidHolder,
    'description': description,
    'id': id,
    'isDone': isDone,
  };
}
