import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goal_setting_app/model/goal.dart';
import 'package:goal_setting_app/provider/goals.dart';
import 'package:goal_setting_app/widget/goal_form_widget.dart';

class EditGoalPage extends StatefulWidget {
  final Goal goal;

  const EditGoalPage({Key? key, required this.goal}) : super(key: key);

  @override
  _EditGoalPageState createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String task_desc;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.goal.title;
    task_desc = widget.goal.task_desc;
    description = widget.goal.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Edit Goal'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            final provider =
            Provider.of<GoalsProvider>(context, listen: false);
            provider.removeGoal(widget.goal);

            Navigator.of(context).pop();
          },
        )
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: GoalFormWidget(
          title: title,
          description: description,
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedTask: (task_desc) => setState(() => this.task_desc= task_desc),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
          onSavedGoal: saveGoal,
        ),
      ),
    ),
  );

  void saveGoal() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final provider = Provider.of<GoalsProvider>(context, listen: false);

      provider.updateGoal(widget.goal, title,task_desc, description);

      Navigator.of(context).pop();
    }
  }
}
