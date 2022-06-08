import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goal_setting_app/page/home_page.dart';
import 'package:goal_setting_app/provider/goals.dart';
import 'package:goal_setting_app/page/sign_in_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoalsProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RoadMap Goal Setting App",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userData){
            if(userData.hasData)
              return HomePage();
            else
              return signInPage();
          }
      )
    ),
  );
}
