import 'package:flutter/material.dart';

class GoalFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String task_desc;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedTask;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedGoal;

  const GoalFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.task_desc ='',
    required this.onChangedTitle,
    required this. onChangedTask,
    required this.onChangedDescription,
    required this.onSavedGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitle(),
        SizedBox(height: 8),
        buildTask(),
        SizedBox(height: 10,),
        buildDescription(),
        SizedBox(height: 10),
        buildButton(),
      ],
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    onChanged: onChangedTitle,
    validator: (title) {
      if (title!.isEmpty) {
        return 'The title cannot be empty';
      }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
    ),
  );
  Widget buildTask() => TextFormField(
    maxLines: 2,
    initialValue: task_desc,
     onChanged: onChangedTask,
     decoration: InputDecoration(
       border: UnderlineInputBorder(),
       labelText: 'Task to Achieve Goal',
     ) ,

  );

  Widget buildDescription() => TextFormField(
    maxLines: 2,
    initialValue: description,
    onChanged: onChangedDescription,
    validator: (title) {
      if (title!.isEmpty) {
        return 'The task to achieve goal cannot be empty';
      }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
    ),
  );

  Widget buildButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
      ),
      onPressed: onSavedGoal,
      child: Text('Save'),
    ),
  );
}
