import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourlab/screens/home.dart';
import 'package:ourlab/screens/logIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email1 = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController name = TextEditingController();

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
              "Sign Up",
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: email1,
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
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                hintText: "can contain: _ , numbers , letters",
                label: Text("Enter your username"),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: pass1,
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
              height: 25,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                hintText: "Re-type password",
                label: Text("Re-type password"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton.icon(
                onPressed: (() async {
                  if (email1.text.isEmpty | pass1.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter email and password !")));
                  } else {
                    try {
                      var authObject1 = FirebaseAuth.instance;
                      UserCredential myUser1 =
                          (await authObject1.createUserWithEmailAndPassword(
                              email: email1.text, password: pass1.text));

                      final User? currentUser = authObject1.currentUser;
                      final UID = currentUser!.uid;

                      final CollectionReference Users =
                          FirebaseFirestore.instance.collection('users');
                      await Users.doc(UID).set({
                        'name': name.text,
                        'email': email1.text,
                        'type': 'user',
                        'ID': UID
                      });

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
                label: Text("Sign Up"),
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
                        return LogIn();
                      },
                    ),
                  );
                },
                child: Text('or Login'))
          ],
        ),
      ),
    );
  }
}
