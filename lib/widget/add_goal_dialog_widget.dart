import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goal_setting_app/model/goal.dart';
import 'package:goal_setting_app/provider/goals.dart';
import 'package:goal_setting_app/widget/goal_form_widget.dart';

class AddGoalDialogWidget extends StatefulWidget {
  @override
  _AddGoalDialogWidgetState createState() => _AddGoalDialogWidgetState();
}

class _AddGoalDialogWidgetState extends State<AddGoalDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String task_desc= '';
  String description = '';
  final String uid = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Goal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          GoalFormWidget(
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedTask: (task_desc) => setState(() => this.task_desc= task_desc),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedGoal: addGoal,
          ),
        ],
      ),
    ),
  );

  void addGoal() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final goal = Goal(
        id: uid,
        title: title,
        task_desc: task_desc,
        uidHolder: uid,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<GoalsProvider>(context, listen: false);
      provider.addGoal(goal);

      Navigator.of(context).pop();
    }
  }
}
