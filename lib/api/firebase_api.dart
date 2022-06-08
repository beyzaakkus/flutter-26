import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goal_setting_app/model/goal.dart';
import 'package:goal_setting_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirebaseApi {

  static Future<String> createGoal(Goal goal) async {
    String currentUid= FirebaseAuth.instance.currentUser!.uid;

    final docGoal = FirebaseFirestore.instance.collection('goal').doc(currentUid).collection('mygoal').doc();

    goal.id = docGoal.id;
    await docGoal.set(goal.toJson());

    return docGoal.id;
  }

  static Stream<List<Goal>> readGoals() => FirebaseFirestore.instance
      .collection('goal')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('mygoal')
      .orderBy(GoalField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Goal.fromJson));

  static Future updateGoal(Goal goal) async {
    final docGoal = FirebaseFirestore.instance.collection('goal').doc(FirebaseAuth.instance.currentUser!.uid).collection('mygoal').doc(goal.id);

    await docGoal.update(goal.toJson());
  }

  static Future deleteGoal(Goal goal) async {
    final docGoal = FirebaseFirestore.instance.collection('goal').doc(FirebaseAuth.instance.currentUser!.uid).collection('mygoal').doc(goal.id);

    await docGoal.delete();
  }
}
