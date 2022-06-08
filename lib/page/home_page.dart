import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goal_setting_app/api/firebase_api.dart';
import 'package:goal_setting_app/model/goal.dart';
import 'package:goal_setting_app/provider/goals.dart';
import 'package:goal_setting_app/widget/add_goal_dialog_widget.dart';
import 'package:goal_setting_app/widget/completed_list_widget.dart';
import 'package:goal_setting_app/widget/goal_list_widget.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      GoalListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('RoadMap Goal Setting'),
        actions: [
          IconButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            List<Goal> _goals = [];
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Achievements',
          ),
        ],
      ),
      body: StreamBuilder<List<Goal>>(
        stream: FirebaseApi.readGoals(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final goals = snapshot.data;

                final provider = Provider.of<GoalsProvider>(context);
                provider.setGoals(goals!);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade900,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddGoalDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
  child: Text(
    text,
    style: TextStyle(fontSize: 24, color: Colors.white),
  ),
);
