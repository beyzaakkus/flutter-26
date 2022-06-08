import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

String? userName,email,password;
bool signed = false;

class _signUpState extends State<signUp> {

  var _autKeyy= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _autKeyy,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: ListView(
          children: [
            if(!signed)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (nameTaken){
                    userName=nameTaken;
                  },
                  validator: (nameTaken){
                    return nameTaken!.isEmpty
                        ? "User name cannot be empty."
                        : null;
                  },
                  decoration: InputDecoration(labelText: "Username: ", border: OutlineInputBorder(),),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (mailTaken){
                  email=mailTaken;
                },
                validator: (mailTaken){
                  return mailTaken!.contains("@")
                      ? null
                      : "Invalid email ";
                },
                decoration: InputDecoration(
                  labelText: "Email: ",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (passwordTaken){
                    password=passwordTaken;
                  },
                  validator: (passwordTaken){
                    return passwordTaken!.length >= 6
                        ? null
                        : "Your password should include at least 6 characters";
                  },
                  decoration: InputDecoration(
                    labelText: "Password: ",
                    border: OutlineInputBorder(),
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  child: signed
                      ?Text("Sign in", style: TextStyle(fontSize: 24))
                      : Text("Sign up", style: TextStyle(fontSize: 24)),
                  onPressed: (){
                    addRegistry();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent,
                      shadowColor: Colors.indigo
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  setState(() {
                    signed = !signed;
                  });
                },
                child: signed
                    ? Text("I don't have an account")
                    : Text("I already have an account"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addRegistry() {
    if(_autKeyy.currentState!.validate()){
      checkForm(email!,password!);
    }
  }

  void checkForm( String email, String password) async{
    final authz = FirebaseAuth.instance;
    AuthCredential? result;

    if(signed){
      result = (await authz.signInWithEmailAndPassword(email: email, password: password)) as AuthCredential;
    }
    else{
      result = (await authz.createUserWithEmailAndPassword(email: email, password: password)) as AuthCredential;
    }

    String uidHold = result.toString();
    await FirebaseFirestore.instance.collection("Users").doc(uidHold).set({
      "userName" : userName, "email": email
    });
  }
}