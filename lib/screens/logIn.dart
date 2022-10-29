import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourlab/screens/home.dart';
import 'package:ourlab/screens/signUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailLogIn = TextEditingController();
  TextEditingController passLogIn = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "Log In",
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: emailLogIn,
              decoration: InputDecoration(
                  label: Text("Enter your email"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  hintText: "eg: example@gmail.com"),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: passLogIn,
              obscureText: true,
              decoration: InputDecoration(
                  label: Text("Enter your Password"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  hintText: "at least 8 charecters"),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton.icon(
                onPressed: (() async {
                  if (emailLogIn.text.isEmpty | passLogIn.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter email and password !")));
                  } else {
                    try {
                      var authObject2 = FirebaseAuth.instance;

                      UserCredential myUser2 =
                          await authObject2.signInWithEmailAndPassword(
                              email: emailLogIn.text, password: passLogIn.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Home();
                          },
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("$e")));
                    }
                  }
                }),
                icon: Icon(Icons.login),
                label: Text("Log In"),
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    backgroundColor: Color.fromARGB(255, 203, 68, 113)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ),
                  );
                },
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
