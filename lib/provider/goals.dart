import 'package:flutter/cupertino.dart';
import 'package:goal_setting_app/api/firebase_api.dart';
import 'package:goal_setting_app/model/goal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoalsProvider extends ChangeNotifier {
  String currentUid= FirebaseAuth.instance.currentUser!.uid;
  List<Goal> _goals = [];

  List<Goal> get goals => _goals.where((mygoal) => mygoal.isDone == false ).toList();

  List<Goal> get GoalsCompleted =>
      _goals.where((mygoal) => mygoal.isDone == true ).toList();

  void setGoals(List<Goal> goals) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _goals = goals;
        notifyListeners();
      });

  void addGoal(Goal goal) => FirebaseApi.createGoal(goal);

  void removeGoal(Goal goal) => FirebaseApi.deleteGoal(goal);

  bool toggleGoalStatus(Goal mygoal) {
    mygoal.isDone = !mygoal.isDone;
    FirebaseApi.updateGoal(mygoal);

    return mygoal.isDone;
  }

  void updateGoal(Goal goal, String title, String task_desc, String description) {
    goal.title = title;
    goal.task_desc= task_desc;
    goal.description = description;

    FirebaseApi.updateGoal(goal);
  }
}
