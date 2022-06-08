import 'package:flutter/material.dart';
import 'package:goal_setting_app/page/sign_up.dart';


class signInPage extends StatefulWidget {
  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In/Up Page"),
        centerTitle: true,
      ),
      body: signUp(),

    );
  }
}