import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:goal_setting_app/model/goal.dart';
import 'package:goal_setting_app/page/edit_goal_page.dart';
import 'package:goal_setting_app/provider/goals.dart';
import 'package:goal_setting_app/utils.dart';

class GoalWidget extends StatelessWidget {
  final Goal goal;

  const GoalWidget({
    required this.goal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      key: Key(goal.id),
      actions: [
        IconSlideAction(
          color: Colors.indigo.shade400,
          onTap: () => editGoal(context, goal),
          caption: 'Edit',
          icon: Icons.edit,
        )
      ],
      secondaryActions: [
        IconSlideAction(
          color: Colors.indigo.shade900,
          caption: 'Delete',
          onTap: () => deleteGoal(context, goal),
          icon: Icons.delete,
        )
      ],
      child: buildGoal(context),
    ),
  );

  Widget buildGoal(BuildContext context) => GestureDetector(
    onTap: () => editGoal(context, goal),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            value: goal.isDone,
            onChanged: (_) {
              final provider =
              Provider.of<GoalsProvider>(context, listen: false);
              final isDone = provider.toggleGoalStatus(goal);

              Utils.showSnackBar(
                context,
                isDone ? 'Task completed' : 'Task marked incomplete',
              );
            },
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top:1),
                  child: Text(goal.title, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                  ),
                  ),
                ),
                Text(
                  goal.task_desc,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );

  void deleteGoal(BuildContext context, Goal goal) {
    final provider = Provider.of<GoalsProvider>(context, listen: false);
    provider.removeGoal(goal);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editGoal(BuildContext context, Goal goal) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditGoalPage(goal: goal),
    ),
  );
}
