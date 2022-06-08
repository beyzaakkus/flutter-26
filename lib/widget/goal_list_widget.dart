import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goal_setting_app/provider/goals.dart';
import 'package:goal_setting_app/widget/goal_widget.dart';

class GoalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoalsProvider>(context);
    final goals = provider.goals;

    return goals.isEmpty
        ? Center(
      child: Text(
        "No goals yet. "
            "Let's change it.",
        style: TextStyle(fontSize: 20),
      ),
    )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(height: 8),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];

        return GoalWidget(goal: goal);
      },
    );
  }
}
